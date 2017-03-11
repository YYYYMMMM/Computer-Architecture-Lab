`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:29:38 05/11/2016
// Design Name:   Top
// Module Name:   F:/COLAB/computer_org/lab6/Top_tx.v
// Project Name:  lab6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_tx;
	// Inputs
	reg clk;
	reg reset;
	reg [3:0] SWITCH;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.reset(reset), 
		.SWITCH(SWITCH), 
		.LED(LED)
	);

	initial begin
        // Initialize Inputs

        clk = 0;
        reset = 1;

        // Wait 100 ns for global reset to finish
        #125
        reset = 0;
        // Add stimulus here

    end
    
	 always
    #50 clk = ~clk;
endmodule

