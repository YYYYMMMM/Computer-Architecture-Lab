`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:56 04/14/2016 
// Design Name: 
// Module Name:    Top 
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
module Top(
    input clk,
    input reset
    );
	 
	wire REG_DST,
		JUMP,
		BRANCH,
		MEM_READ,
		MEM_TO_REG,
		MEM_WRITE;
	wire[1:0] ALU_OP;
	wire ALU_SRC,
		REG_WRITE;
	wire [3:0]ALU_CTR;	
	wire [31:0]READ_DATA1;
	wire [31:0]READ_DATA2;
	
	wire [31:0]SIGN_EXTNUM;
	wire [31:0]ALU_IN2;
	wire ALU_OUT_ZERO;
	wire [31:0]ALU_RESULT;
	
	wire [4:0]WRITE_REG;
	wire [31:0]WRITE_DATA;
	
	wire [31:0]READ_DATA;
	
	wire [27:0]INST_SHL;
	wire [31:0]PC_ADD4;
	wire [31:0]JUMP_ADDR;
	wire [31:0]PC_NEXT;
	wire [31:0]SIGN_EXTNUM_SHL;
	
	wire [31:0]ALU2_RESULT;
	wire [31:0]PC_NEXT_PRE;
	
	reg [31:0] PC;
	reg [31:0] MEM[255:0];
	reg [31:0] INST;
	
	
	
	
	initial 
	begin
		$readmemb("instInitial",MEM,'h00000000);
		//$readmemh("dataInitial",memFile,32'b0);
		PC = 0;
		
	end
	
	assign ALU_IN2 = ALU_SRC ? SIGN_EXTNUM : READ_DATA2;
	assign WRITE_REG = REG_DST ? INST[15:11] : INST[20:16];
	assign WRITE_DATA = 	MEM_TO_REG ? READ_DATA : ALU_RESULT;
	assign PC_NEXT_PRE = (BRANCH & ALU_OUT_ZERO) ? ALU2_RESULT : PC_ADD4;
	assign PC_NEXT = JUMP ? JUMP_ADDR : PC_NEXT_PRE;
	
	
	assign INST_SHL = INST[25:0]<<2;
	assign PC_ADD4 = PC + 4;
	assign JUMP_ADDR = {PC_ADD4[31:28],INST_SHL};
	assign SIGN_EXTNUM_SHL = SIGN_EXTNUM<<2;
	assign ALU2_RESULT = PC_ADD4 + SIGN_EXTNUM_SHL;
	
	always @(posedge clk)
	begin
		PC = PC_NEXT;
		if(reset)
		begin
			PC = 0;
		end
	end
	
	always @(PC)
	begin
		INST = MEM[PC>>2];
	end
	
	
	

	
	Ctr mainCtr(
			.opCode(INST[31:26]),
			.regDst(REG_DST),
			.jump(JUMP),
			.branch(BRANCH),
			.memRead(MEM_READ),
			.memToReg(MEM_TO_REG),
			.aluOp(ALU_OP),
			.memWrite(MEM_WRITE),
			.aluSrc(ALU_SRC),
			.regWrite(REG_WRITE)
			);
	
	aluCtrOut mainAluCtr(
			.aluOp(ALU_OP),
			.funct(INST[5:0]),
			.aluCtr(ALU_CTR)
		);
	
	Alu mainAlu(
			.input1(READ_DATA1),
			.input2(READ_DATA2),
			.aluCtr(ALU_CTR),
			.zero(ALU_OUT_ZERO),
			.aluRes(ALU_RESULT)
		);
	

	register mainRegister(
			.clock_in(clk),
			.readReg1(INST[25:21]),
			.readReg2(INST[20:16]),
			.writeReg(WRITE_REG),
			.writeData(WRITE_DATA),
			.regWrite(REG_WRITE),
			.reset(reset),
			.readData1(READ_DATA1),
			.readData2(READ_DATA2)
	);

	data_memory mainMemory(
			.clock_in(clk),
			.address(ALU_RESULT),
			.writeData(READ_DATA2),
			.memWrite(MEM_WRITE),
			.memRead(MEM_READ),
			.readData(READ_DATA)
		);
		
	signext mainSignExt(
			.inst(INST[15:0]),
			.data(SIGN_EXTNUM)
		);
	
endmodule
