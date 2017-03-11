`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:29:51 04/06/2016
// Design Name:   top_module
// Module Name:   F:/COLAB/EELABS/mylab/auto_seller__/tset.v
// Project Name:  auto_seller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tset;

	// Inputs
	reg clk;
	reg coin_half;
	reg coin_one;
	reg sell_cola;
	reg sell_tea;
	reg sell_milk;
	reg account;

	// Outputs
	wire [3:0] an;
	wire [6:0] a_to_g;
	wire DP;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.coin_half(coin_half), 
		.coin_one(coin_one), 
		.sell_cola(sell_cola), 
		.sell_tea(sell_tea), 
		.sell_milk(sell_milk), 
		.account(account), 
		.an(an), 
		.a_to_g(a_to_g), 
		.DP(DP)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		coin_half = 0;
		coin_one = 0;
		sell_cola = 0;
		sell_tea = 0;
		sell_milk = 0;
		account = 0;

		// Wait 100 ns for global reset to finish
		
		#100;
       coin_half = 1; 
		#100;
		 account = 1;
		#100
		 coin_half = 0;
		 account = 0 ;
		 sell_cola = 1;
		#100
		 account = 1;
		 // Add stimulus here

	end
    always #50 clk = ~clk;  
endmodule

