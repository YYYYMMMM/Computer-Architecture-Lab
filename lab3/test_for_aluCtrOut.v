`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:36:16 04/07/2016
// Design Name:   aluCtrOut
// Module Name:   F:/COLAB/computer_org/lab3/test_for_aluCtrOut.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aluCtrOut
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_aluCtrOut;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	aluCtrOut uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		  
		// Add stimulus here
		#100 	aluOp = 2'b00;
				funct = 6'bxxxxxx;
		#100 	aluOp = 2'bx1;
				funct = 6'bxxxxxx;
		#100 	aluOp = 2'b1x;
				funct = 6'bxx0000;				
		#100 	aluOp = 2'b1x;
				funct = 6'bxx0010;		 
		#100 	aluOp = 2'b1x;
				funct = 6'bxx0100;		
		#100 	aluOp = 2'b1x;
				funct = 6'bxx0101;		
		#100 	aluOp = 2'b1x;
				funct = 6'bxx1010;
	end
      
endmodule

