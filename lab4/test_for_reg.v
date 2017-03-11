`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:46:31 04/14/2016
// Design Name:   register
// Module Name:   F:/COLAB/computer_org/lab4/test_for_reg.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_reg;

	// Inputs
	reg clock_in;
	reg [25:21] readReg1;
	reg [20:16] readReg2;
	reg [4:0] writeReg;
	reg [31:0] writeData;
	reg regWrite;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;

	// Instantiate the Unit Under Test (UUT)
	register uut (
		.clock_in(clock_in), 
		.readReg1(readReg1), 
		.readReg2(readReg2), 
		.writeReg(writeReg), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.readData1(readData1), 
		.readData2(readData2)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		regWrite = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		#50;
		regWrite = 1'b1;
		writeReg = 5'b10101;
		writeData = 'hFAFA0C0C;
		readReg1[25:21] = 5'b00000;
		readReg2[20:16] = 5'b00000;
		#50;
		regWrite = 1'b0;
		writeReg = 5'b10101;
		writeData = 'h00000000;
		readReg1[25:21] = 5'b00000;
		readReg2[20:16] = 5'b101010;
		#50;
		regWrite = 1'b0; 
		writeReg = 5'b10101;
		writeData = 'h00000000;
		readReg1[25:21] = 5'b00000;
		readReg2[20:16] = 5'b10101;
		#50;
		regWrite = 1'b1; 
		writeReg = 5'b01010;
		writeData = 'hABCDABCD;
		readReg1[25:21] = 5'b01010;
		readReg2[20:16] = 5'b10101;
		#50;
		regWrite = 1'b0; 
		writeReg = 5'b01010;
		writeData = 'hABCDABCD;
		readReg1[25:21] = 5'b01010;
		readReg2[20:16] = 5'b10101;	
	end
	always
	#25 clock_in = ~clock_in;
endmodule

