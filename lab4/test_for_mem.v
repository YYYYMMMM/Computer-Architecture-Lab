`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:35:10 04/14/2016
// Design Name:   data_memory
// Module Name:   F:/COLAB/computer_org/lab4/test_for_mem.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_mem;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memWrite;
	reg memRead;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clock_in(clock_in), 
		.address(address), 
		.writeData(writeData), 
		.memWrite(memWrite), 
		.memRead(memRead), 
		.readData(readData)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memWrite = 0;
		memRead = 0;

		// Wait 100 ns for global reset to finish
		#100
        
		// Add stimulus here
		
		#50
		clock_in = 1;
		
		#50
		memWrite = 1'b1;
		address = 15;
		writeData = 1;
		
		#50
		clock_in = 0;
		#50
		clock_in = 1;
		#50 
		memRead = 1'b1;
		#50
		clock_in = 0;
		#50
		clock_in = 1;
		#50
		memRead = 1'b1;
		memWrite = 1'b0;
		#50
		clock_in = 0;
	end
	
	
endmodule

