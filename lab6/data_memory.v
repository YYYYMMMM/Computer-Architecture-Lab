`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:06:34 04/14/2016 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(
		input clock_in,
		input [31:0] address,
		input [31:0] writeData,
		input memWrite,
		input memRead,
		output reg [31:0] readData
    );
	
	reg [31:0] memFile[0:127];
	

	integer i;
	initial
	begin
		for(i=0;i<128;i=i+1)
			memFile[i] = 1;
	end
	
	always @(address or writeData or memWrite or memRead)
	begin
		readData = memFile[address];
	end
	
	always @(negedge clock_in)
	begin
		if(memWrite == 1)
			memFile[address] = writeData;
	end
	
endmodule
