`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:55:17 04/06/2016 
// Design Name: 
// Module Name:    counter 
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
module  timeDivider(
	input clockIn,
	output reg clockOut
);

	reg[23:0] buffer;
	
	always@ (posedge clockIn)
	begin
		buffer <= buffer + 1;
		clockOut <= &buffer;
	end
endmodule

module counter(
    input mainClock,
    input reset,
    output reg [3:0] count
    );
	wire slowClock;
	
	timeDivider td(.clockIn(mainClock),.clockOut(slowClock));
	
	always @(posedge slowClock)
	begin
		if(!reset)
			count <= 4'b1111;
		else 
			count <= count - 1;
	end

endmodule
