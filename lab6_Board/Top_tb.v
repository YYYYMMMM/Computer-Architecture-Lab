`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:34:27 05/12/2016
// Design Name:   Top
// Module Name:   F:/COLAB/computer_org/lab6_Board/Top_tb.v
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

module Top_tb;

	// Inputs
	reg mainClk;
	reg reset;
	reg [2:0] select;
	reg showPC;

	// Outputs
	wire [7:0] LED_out;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.mainClk(mainClk), 
		.reset(reset), 
		.select(select), 
		.showPC(showPC), 
		.LED_out(LED_out)
	);

	initial begin
		// Initialize Inputs
		mainClk = 0;
		reset = 1;
		select = 1;
		showPC = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;  
		// Add stimulus here

	end
   
	always
    #50 mainClk = ~mainClk;   
endmodule
/*
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
*/
