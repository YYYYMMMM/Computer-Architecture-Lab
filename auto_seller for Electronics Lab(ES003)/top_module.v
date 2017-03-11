`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:01 03/30/2016 
// Design Name: 
// Module Name:    top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module led_module(
	input [3:0] NUM,
	output reg [6:0] a_to_g
	);
	always @(*) 
		case(NUM)
		0:a_to_g=7'b0000001;
		1:a_to_g=7'b1001111;
		2:a_to_g=7'b0010010;
		3:a_to_g=7'b0000110;
		4:a_to_g=7'b1001100;
		5:a_to_g=7'b0100100;
		6:a_to_g=7'b0100000;
		7:a_to_g=7'b0001111;
		8:a_to_g=7'b0000000;
		9:a_to_g=7'b0000100;
		'hA: a_to_g=7'b0001000;
		'hB: a_to_g=7'b1100000;
		'hC: a_to_g=7'b0110001;
		'hD: a_to_g=7'b1000010;
		'hE: a_to_g=7'b0110000;
		'hF: a_to_g=7'b0111000;
		default: a_to_g=7'b0000001; 
	endcase 

endmodule


module top_module( 
	input clk,
	input coin_half,                        
	input coin_one,							
	input sell_cola,
	input sell_tea,
	input sell_milk,
	input full_stock,
	input account,
	input coin_return,
	output reg cola_out,
	output reg tea_out,
	output reg milk_out,
	output[3:0]an,
	output[6:0]a_to_g,	
	output DP
    );
	
	reg [32:0]clk_cnt;                     //clock count
	reg [3:0]NUM;                         //number printed on the segment LEDs
	wire [1:0]s ;
	wire q;
	reg [2:0]stock_cola;
	reg [2:0]stock_milk;
	reg [2:0]stock_tea;
	reg [15:0]total_money;
	reg [15:0]display;
	reg carry0;
	reg carry1;
	reg carry2;
	reg carry3;
	reg carry4;
	reg timer;
	reg [26:0]timer_cnt;
	
	reg not_spark;
	
	initial
		begin
			stock_cola = 5;
			stock_milk = 5;
			stock_tea = 5;
			carry0 = 0;
			carry1 = 0;
			carry2 = 0;
			carry3 = 0;
			carry4 = 0;
			not_spark = 0;
			total_money = 0;
			clk_cnt = 0;
			timer = 0;
			timer_cnt = 0;
			display = 0;
		end
	

	always @(posedge clk )         //deal the clock and clear events
	begin
		if(timer==0)
			timer_cnt = 0;
		if (timer==1 && account == 1)
		begin
			timer_cnt = 0;
			timer_cnt = timer_cnt - 1;
		end
		clk_cnt = clk_cnt +1;                     //if clock flip, count clock 
			if(clk_cnt[32:29]>15)                    //if count was full, back to zero
			 clk_cnt = 0; 
		if(timer_cnt != 0)
			timer_cnt = timer_cnt - 1;
	end 

	
	always @(posedge account)
		begin
			timer = 0;
			if(coin_one)
				total_money[7:4] = total_money[7:4] + 1;
				if(total_money[3:0]>9)
				begin
					total_money[3:0] = total_money[3:0] - 10;
					total_money[7:4] = total_money[7:4] + 1;
				end
				if(total_money[7:4]>9)
				begin
					total_money[7:4] = total_money[7:4] - 10;
					total_money[11:8] = total_money[11:8] + 1;
				end
				if(total_money[11:8]>9)
				begin
					total_money[11:8] = total_money[11:8] - 10;
					total_money[15:12] = total_money[15:12] + 1;
				end				
				display = total_money;
				not_spark = 1;
				cola_out = 0;
				tea_out = 0;
				milk_out = 0;
			if(coin_half)
				total_money[3:0] = total_money[3:0] + 5;
				if(total_money[3:0]>9)
				begin
					total_money[3:0] = total_money[3:0] - 10;
					total_money[7:4] = total_money[7:4] + 1;
				end
				if(total_money[7:4]>9)
				begin
					total_money[7:4] = total_money[7:4] - 10;
					total_money[11:8] = total_money[11:8] + 1;
				end
				if(total_money[11:8]>9)
				begin
					total_money[11:8] = total_money[11:8] - 10;
					total_money[15:12] = total_money[15:12] + 1;
				end								
				display = total_money;
				not_spark = 1;
				cola_out = 0;
				tea_out = 0;
				milk_out = 0;		
			if(full_stock)
				begin
					stock_cola = 5;
					stock_tea = 5;
					stock_milk = 5;
					display = total_money;
					not_spark = 1;
					cola_out = 0;
					tea_out = 0;
					milk_out = 0;
				end
			if(coin_return)
				begin
					display = total_money;
					total_money = 0;
					not_spark = 0;
					cola_out = 0;
					tea_out = 0;
					milk_out = 0;
				end
			if(sell_cola)
				begin
					if(stock_cola == 0)
					begin
						display = 'hFFFF;
						not_spark = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;
					end
					else if(total_money < 'h0020)
					begin
						display = 'h0020;
						not_spark = 0;
						timer = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;					
					end
					else
					begin
					total_money[7:4] = total_money[7:4] - 2;
					
					
					if(total_money[3:0]>9)
					begin
						total_money[3:0] = total_money[3:0] - 6;
						total_money[7:4] = total_money[7:4] - 1;
					end
					if(total_money[7:4]>9)
					begin
						total_money[7:4] = total_money[7:4] - 6;
						total_money[11:8] = total_money[11:8] - 1;
					end
					if(total_money[11:8]>9)
					begin
						total_money[11:8] = total_money[11:8] - 6;
						total_money[15:12] = total_money[15:12] - 1;
					end									
					if(total_money[15:12]>9)
						total_money[15:12] = total_money[15:12] - 6;					
					
					
					
					stock_cola = stock_cola - 1;
					display = total_money;
					not_spark = 1;
					cola_out = 1;
					end
				end
			if(sell_tea)
				begin
					if(stock_tea == 0)
					begin
						display = 'hFFFF;
						not_spark = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;						
					end
					else if(total_money < 'h0030)
						begin
						display = 'h0030;
						not_spark = 0;
						timer = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;						
						end
					else
					begin
					total_money[7:4] = total_money[7:4] - 3;
					
					
					if(total_money[3:0]>9)
					begin
						total_money[3:0] = total_money[3:0] - 6;
						total_money[7:4] = total_money[7:4] - 1;
					end
					if(total_money[7:4]>9)
					begin
						total_money[7:4] = total_money[7:4] - 6;
						total_money[11:8] = total_money[11:8] - 1;
					end
					if(total_money[11:8]>9)
					begin
						total_money[11:8] = total_money[11:8] - 6;
						total_money[15:12] = total_money[15:12] - 1;
					end					
					if(total_money[15:12]>9)
						total_money[15:12] = total_money[15:12] - 6;
					
					
					stock_tea = stock_tea - 1;
					display = total_money;
					not_spark = 1;
					tea_out = 1;
					end
				end
			if(sell_milk)
				begin
					if(stock_milk == 0)
					begin
						display = 'hFFFF;
						not_spark = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;						
					end
					else if(total_money < 'h0035)
						begin
						display = 'h0035;
						not_spark = 0;
						timer = 1;
						cola_out = 0;
						tea_out = 0;
						milk_out = 0;						
						end
					else
					begin
					total_money[3:0] = total_money[3:0] - 5;
					
					
					if(total_money[3:0]>9)
					begin
						total_money[3:0] = total_money[3:0] - 6;
						total_money[7:4] = total_money[7:4] - 1;
					end
					if(total_money[7:4]>9)
					begin
						total_money[7:4] = total_money[7:4] - 6;
						total_money[11:8] = total_money[11:8] - 1;
					end
					if(total_money[11:8]>9)
					begin
						total_money[11:8] = total_money[11:8] - 6;
						total_money[15:12] = total_money[15:12] - 1;
					end					
					if(total_money[15:12]>9)
						total_money[15:12] = total_money[15:12] - 6;					
					
					total_money[7:4] = total_money[7:4] - 3;
					
					
					if(total_money[3:0]>9)
					begin
						total_money[3:0] = total_money[3:0] - 6;
						total_money[7:4] = total_money[7:4] - 1;
					end
					if(total_money[7:4]>9)
					begin
						total_money[7:4] = total_money[7:4] - 6;
						total_money[11:8] = total_money[11:8] - 1;
					end
					if(total_money[11:8]>9)
					begin
						total_money[11:8] = total_money[11:8] - 6;
						total_money[15:12] = total_money[15:12] - 1;
					end					
					if(total_money[15:12]>9)
						total_money[15:12] = total_money[15:12] - 6;						
					
				
					stock_milk = stock_milk - 1;
					display = total_money;
					not_spark = 1;
					milk_out = 1;
					end
				end			
		end
		
		
		
	assign s[1:0] = clk_cnt[16:15];         //ΩªÃÊœ‘ æ
	assign q = clk_cnt[25];

	assign an[0] = (s[0])||(s[1]) || (~not_spark && q && timer_cnt) ;
	assign an[1] = (~s[0])||s[1] || (~not_spark && q && timer_cnt) ;
	assign an[2] = s[0]||(~s[1]) || (~not_spark && q && timer_cnt) ;
	assign an[3] = (~s[0])||(~s[1])|| (~not_spark && q && timer_cnt) ;	
	assign DP = (~s[0])||s[1] || (~not_spark && q && timer_cnt) ;
//////////////////////////////////////////////////////////


	always @(*) 
		case(s[1:0])                         
				2'b00: NUM = display[3:0];
				2'b01: NUM = display[7:4];
				2'b10: NUM = display[11:8];
				2'b11: NUM = display[15:12];
		endcase
	
	
	
	

	led_module  A1(.NUM(NUM),
						.a_to_g(a_to_g));

endmodule


