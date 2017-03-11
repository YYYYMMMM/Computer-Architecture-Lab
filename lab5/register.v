`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:08:38 04/14/2016 
// Design Name: 
// Module Name:    register 
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
module register(
		input clock_in,
		input [25:21] readReg1,
		input [20:16] readReg2,
		input [4:0] writeReg,
		input [31:0] writeData,
		input regWrite,
		input reset,
		output reg [31:0]readData1,
		output reg [31:0]readData2
    );
	reg [31:0] regFile[31:0];

	integer i;
	/*
	initial
	begin
		for(i=0;i<32;i=i+1)
			regFile[i] = 0;
	end
	*/
	initial
	begin
		$readmemb("regInitial",regFile,32'b0);
	end
	
	
	always@(readReg1 or readReg2 or writeReg or writeData or regWrite)
	begin
		readData1 = regFile[readReg1];
		readData2 = regFile[readReg2];
	end
	
	always@ (negedge clock_in)
	begin
		if(regWrite)
			regFile[writeReg] = writeData;
	end
	
	always@ (reset)
	begin
		if(reset)
		begin
			for(i=0;i<32;i=i+1)
			regFile[i] = 0;
		end
	end
		
endmodule
