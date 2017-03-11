`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:45 03/17/2016 
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
module InstructionMemory(
	input [31:0] ADDR,
	input CLK,
	input RESET,
	output reg [31:0] INST
	);
	 
	reg [31:0] instMemFile [0:63];
	integer i;	 
	initial begin
		instMemFile[0]=32'b00000000000000000000000000000000;
		instMemFile[1]=32'b10001100000000010000000000000001;
		instMemFile[2]=32'b10001100000000100000000000000010;
		instMemFile[3]=32'b00000000000000000000000000000000;
		instMemFile[4]=32'b00000000000000000000000000000000;
		instMemFile[5]=32'b00000000000000000000000000000000;
		instMemFile[6]=32'b00000000001000100001100000100000;
		instMemFile[7]=32'b00000000000000000000000000000000;
		instMemFile[8]=32'b00000000010000010010000000100010;
		instMemFile[9]=32'b00000000010000010010100000100100;
		instMemFile[10]=32'b00000000100000100011000000100101;
		instMemFile[11]=32'b00000000110000010011100000100000;
		instMemFile[12]=32'b10101100000001110000000000000111;
		instMemFile[13]=32'b00000000010000110000100000101010;
		instMemFile[14]=32'b00000000100000100000100000101010;
		instMemFile[15]=32'b00010000000000000000000000000011;
		instMemFile[16]=32'b00000000010000010010000000100000;
		instMemFile[17]=32'b00000000000000000000000000000000;
		instMemFile[18]=32'b00000000000000000000000000000000;
		instMemFile[19]=32'b00000000000000100001100000100000;

		
		for(i = 20 ; i < 63; i = i+ 1)
		begin
			instMemFile[i] = 0;
		end
		

	 INST = 0;
	 end
	 
	 always@(ADDR)
	 begin
		INST = instMemFile[ADDR>>2];
	 end
endmodule


module Top(
    input clk,
    input reset
    );	 
	reg [31:0] PC;
	//1.0 IF -> ID
	reg [31:0] IF_ID_PC_ADD4;
	reg [31:0] IF_ID_INST;
	//2.0 ID -> EX
	reg [31:0] ID_EX_PC_ADD4;
	reg [31:0] ID_EX_READ_DATA1;
	reg [31:0] ID_EX_READ_DATA2;
	reg [31:0] ID_EX_SIGN_EXTNUM;
	reg [20:16] ID_EX_Rd;
	reg [15:11] ID_EX_Rt;
	reg ID_EX_REG_DST;
	reg ID_EX_BRANCH;
	reg ID_EX_MEM_READ;
	reg ID_EX_MEM_TO_REG;
	reg ID_EX_MEM_WRITE;
	reg [1:0] ID_EX_ALUOP;
	reg ID_EX_ALU_SRC;
	reg ID_EX_REG_WRITE;
	//3.0 EX -> MEM
	reg [31:0] EX_MEM_PC_ADD4;
	reg [31:0] EX_MEM_READ_DATA2;
	reg EX_MEM_ALU_OUT_ZERO;
	reg [4:0] EX_MEM_WRITE_REG;
	reg [31:0] EX_MEM_ALU_RESULT;
	reg EX_MEM_BRANCH;
	reg EX_MEM_MEM_READ;
	reg EX_MEM_MEM_TO_REG; 
	reg EX_MEM_MEM_WRITE;
	reg EX_MEM_REG_WRITE;	 
	 //4.0 MEM -> WB
	reg [31:0] MEM_WB_READ_DATA;
	reg [31:0] MEM_WB_ALU_RESULT;
	reg [4:0] MEM_WB_WRITE_REG;
	reg MEM_WB_REG_WRITE;
	reg MEM_WB_MEM_TO_REG;

	
	wire [31:0] INST;
	wire ID_REG_DST,
		ID_JUMP,
		ID_BRANCH,
		ID_MEM_READ,
		ID_MEM_TO_REG,
		ID_MEM_WRITE;
	wire [1:0] ID_ALU_OP;
	wire ID_ALU_SRC;
	wire [31:0] ID_INST;	
	wire [31:0] ID_READ_DATA1;
	wire [31:0] ID_READ_DATA2;
	wire [31:0] ID_SIGN_EXTNUM;
	wire ID_REG_WRITE;
	wire EX_REG_DST;
	wire [1:0] EX_ALU_OP;
	wire EX_ALU_SRC;
	wire [3:0] EX_ALU_CTR;
	wire [31:0] EX_READ_DATA1;	
	wire [31:0] EX_ALU_IN2;
	wire EX_ALU_OUT_ZERO;	
	wire [31:0] EX_ALU_RESULT;
	wire MEM_MEM_WRITE;
	wire MEM_MEM_READ;
	wire [31:0] MEM_ALU_RESULT;
	wire [31:0] MEM_READ_DATA2;
	wire [31:0] MEM_READ_DATA;
	wire WB_MEM_TO_REG;
	wire [31:0] EX_PC_NEXT_PRE;
	wire [31:0] WB_WRITE_DATA;
	
	assign ID_INST = IF_ID_INST;
	
	
	assign EX_REG_DST = ID_EX_REG_DST;
	assign EX_ALU_OP = ID_EX_ALUOP;
	assign EX_ALU_SRC = ID_EX_ALU_SRC;

	assign EX_READ_DATA1 = ID_EX_READ_DATA1;
	assign EX_ALU_IN2 = ID_EX_ALU_SRC ? ID_EX_SIGN_EXTNUM : ID_EX_READ_DATA2;	
	assign MEM_MEM_WRITE = EX_MEM_MEM_WRITE;
	assign MEM_MEM_READ = EX_MEM_MEM_READ;
	assign MEM_ALU_RESULT = EX_MEM_ALU_RESULT;
	assign MEM_READ_DATA2 = EX_MEM_READ_DATA2;	
	assign WB_MEM_TO_REG = MEM_WB_MEM_TO_REG;	
	
	assign WB_WRITE_DATA = MEM_WB_MEM_TO_REG ? MEM_WB_READ_DATA : MEM_WB_ALU_RESULT;
	assign EX_PC_NEXT_PRE = (EX_MEM_BRANCH & EX_MEM_ALU_OUT_ZERO) ? EX_MEM_PC_ADD4 : (PC + 4);
	
	initial
	begin
		PC <= 0;
		IF_ID_PC_ADD4 <= 0;
		IF_ID_INST <= 0;
		ID_EX_PC_ADD4 <= 0;
		ID_EX_READ_DATA1 <= 0;
		ID_EX_READ_DATA2 <= 0;
		ID_EX_SIGN_EXTNUM <= 0;
		ID_EX_Rd <= 0;
		ID_EX_Rt <= 0;
		ID_EX_REG_DST <= 0;
		ID_EX_ALUOP <= 0;
		ID_EX_ALU_SRC <= 0;
		ID_EX_BRANCH <= 0;
		ID_EX_MEM_READ <= 0;
		ID_EX_MEM_WRITE <= 0;
		ID_EX_REG_WRITE <= 0;
		ID_EX_MEM_TO_REG <= 0;
		EX_MEM_PC_ADD4 <= 0;
		EX_MEM_READ_DATA2 <= 0;
		EX_MEM_ALU_OUT_ZERO <= 0;
		EX_MEM_WRITE_REG <= 0;
		EX_MEM_ALU_RESULT <= 0;
		EX_MEM_BRANCH <= 0;
		EX_MEM_MEM_READ <= 0;
		EX_MEM_MEM_WRITE <= 0;
		EX_MEM_REG_WRITE <= 0;
		EX_MEM_MEM_TO_REG <= 0;
		MEM_WB_READ_DATA <= 0;
		MEM_WB_ALU_RESULT <= 0;
		MEM_WB_WRITE_REG <= 0;
		MEM_WB_REG_WRITE <= 0;
		MEM_WB_MEM_TO_REG <= 0;
	end

	
	InstructionMemory INSTMEM(
		.CLK(clk),
		.ADDR(PC),
		.RESET(reset),
		.INST(INST)
		);


	Ctr mainCtr(
		.opCode(ID_INST[31:26]),
		.regDst(ID_REG_DST),
		.jump(ID_JUMP),
		.branch(ID_BRANCH),
		.memRead(ID_MEM_READ),
		.memToReg(ID_MEM_TO_REG),
		.aluOp(ID_ALU_OP),
		.memWrite(ID_MEM_WRITE),
		.aluSrc(ID_ALU_SRC),
		.regWrite(ID_REG_WRITE)
		);

	aluCtrOut mainAluCtr(
		.aluOp(EX_ALU_OP),
		.funct(ID_EX_SIGN_EXTNUM[5:0]),
		.aluCtr(EX_ALU_CTR)
		);

	Alu mainAlu(
		.input1(EX_READ_DATA1),
		.input2(EX_ALU_IN2),
		.aluCtr(EX_ALU_CTR),
		.zero(EX_ALU_OUT_ZERO),
		.aluRes(EX_ALU_RESULT)
		);		
	 
	register mainRegister(
		.clock_in(clk),
		.readReg1(ID_INST[25:21]),
		.readReg2(ID_INST[20:16]),
		.writeReg(MEM_WB_WRITE_REG),
		.writeData(WB_WRITE_DATA),
		.regWrite(MEM_WB_REG_WRITE),
		.reset(reset),
		.readData1(ID_READ_DATA1),
		.readData2(ID_READ_DATA2)
		);
    

	signext mainSignExt(
		.inst(ID_INST[15:0]),
		.data(ID_SIGN_EXTNUM)
		);

	data_memory mainMemory(
		.clock_in(clk),	
		.address(MEM_ALU_RESULT),
		.writeData(MEM_READ_DATA2),		
		.memWrite(MEM_MEM_WRITE),
		.memRead(MEM_MEM_READ),
		.readData(MEM_READ_DATA)
		);

				
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			PC <= 0;
			IF_ID_PC_ADD4 <= 0;
			IF_ID_INST <= 0;
			ID_EX_PC_ADD4 <= 0;
			ID_EX_READ_DATA1 <= 0;
			ID_EX_READ_DATA2 <= 0;
			ID_EX_SIGN_EXTNUM <= 0;
			ID_EX_Rd <= 0;
			ID_EX_Rt <= 0;
			ID_EX_REG_DST <= 0;
			ID_EX_ALUOP <= 0;
			ID_EX_ALU_SRC <= 0;
			ID_EX_BRANCH <= 0;
			ID_EX_MEM_READ <= 0;
			ID_EX_MEM_WRITE <= 0;
			ID_EX_REG_WRITE <= 0;
			ID_EX_MEM_TO_REG <= 0;
			EX_MEM_PC_ADD4 <= 0;
			EX_MEM_READ_DATA2 <= 0;
			EX_MEM_ALU_OUT_ZERO <= 0;
			EX_MEM_WRITE_REG <= 0;
			EX_MEM_ALU_RESULT <= 0;
			EX_MEM_BRANCH <= 0;
			EX_MEM_MEM_READ <= 0;
			EX_MEM_MEM_WRITE <= 0;
			EX_MEM_REG_WRITE <= 0;
			EX_MEM_MEM_TO_REG <= 0;
			MEM_WB_READ_DATA <= 0;
			MEM_WB_ALU_RESULT <= 0;
			MEM_WB_WRITE_REG <= 0;
			MEM_WB_REG_WRITE <= 0;
			MEM_WB_MEM_TO_REG <= 0;	
		end
		else
			if((EX_MEM_BRANCH & EX_MEM_ALU_OUT_ZERO) == 1)
			begin
			IF_ID_INST <= 0;
			ID_EX_MEM_WRITE <= 0;
			ID_EX_REG_WRITE <= 0;
			EX_MEM_MEM_WRITE <= 0;
			EX_MEM_REG_WRITE <= 0;
			PC <= EX_PC_NEXT_PRE;
			EX_MEM_BRANCH <= 0;
			EX_MEM_ALU_OUT_ZERO <= 0;
			end
		else
		begin
			MEM_WB_REG_WRITE <= EX_MEM_REG_WRITE;
			MEM_WB_READ_DATA <= MEM_READ_DATA;
			MEM_WB_ALU_RESULT <= EX_MEM_ALU_RESULT;
			MEM_WB_WRITE_REG <= EX_MEM_WRITE_REG;
			MEM_WB_MEM_TO_REG <= EX_MEM_MEM_TO_REG;
			EX_MEM_BRANCH <= ID_EX_BRANCH;
			EX_MEM_MEM_READ <= ID_EX_MEM_READ;
			EX_MEM_MEM_TO_REG <= ID_EX_MEM_TO_REG;
			EX_MEM_REG_WRITE <= ID_EX_REG_WRITE;
			EX_MEM_MEM_WRITE <= ID_EX_MEM_WRITE;
			EX_MEM_PC_ADD4 <= ID_EX_PC_ADD4 + (ID_EX_SIGN_EXTNUM<<2);
			EX_MEM_READ_DATA2 <= ID_EX_READ_DATA2;
			EX_MEM_ALU_OUT_ZERO <= EX_ALU_OUT_ZERO;
			EX_MEM_WRITE_REG <= ID_EX_REG_DST ? ID_EX_Rt[15:11] : ID_EX_Rd[20:16];
			EX_MEM_ALU_RESULT <= EX_ALU_RESULT;
			ID_EX_ALUOP <= ID_ALU_OP;
			ID_EX_ALU_SRC <= ID_ALU_SRC;
			ID_EX_BRANCH <= ID_BRANCH;
			ID_EX_MEM_READ <= ID_MEM_READ;
			ID_EX_MEM_WRITE <= ID_MEM_WRITE;
			ID_EX_REG_WRITE <= ID_REG_WRITE;
			ID_EX_MEM_TO_REG <= ID_MEM_TO_REG;
			ID_EX_REG_DST <= ID_REG_DST;
			ID_EX_PC_ADD4 <= IF_ID_PC_ADD4;
			ID_EX_READ_DATA1 <= ID_READ_DATA1;
			ID_EX_READ_DATA2 <= ID_READ_DATA2;
			ID_EX_SIGN_EXTNUM <= ID_SIGN_EXTNUM;
			ID_EX_Rt <= ID_INST[15:11];
			ID_EX_Rd <= ID_INST[20:16];
			IF_ID_PC_ADD4 <= PC+4;
			PC <= EX_PC_NEXT_PRE;
			IF_ID_INST <= INST;
		end
	end

endmodule







/*
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:57:23 04/23/2016 
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
module InstructionMemory(
		input [31:0]address,
		input CLK,
		input RESET,
		output reg [31:0]readData
    );
	 
	 reg [31:0] instMemFile[0:63];
	 
	 always @(address)
	 begin
		readData = instMemFile[address>>2];
	 end

endmodule

module Top(
	input mainClk,
	input reset
	
);
	wire clk;
	assign clk = mainClk;
	
	wire ID_REG_DST, //
		ID_JUMP,
		ID_BRANCH,//
		ID_MEM_READ,//
		ID_MEM_TO_REG,//
		ID_MEM_WRITE;//
	wire[1:0] ID_ALU_OP;//
	wire ID_ALU_SRC,//
		ID_REG_WRITE;//
		
	wire [1:0]IF_ALU_OP;
	
	wire [3:0]ALU_CTR;//	
	wire [31:0]READ_DATA1;//
	wire [31:0]READ_DATA2;//
	
	wire [31:0]SIGN_EXTNUM;//
	wire [31:0]ALU_IN2;//
	wire ALU_OUT_ZERO;//
	wire [31:0]ALU_RESULT;//
	
	wire [4:0]WRITE_REG;//
	wire [31:0]WRITE_DATA;
	
	wire [31:0]READ_DATA;//
	
	wire [27:0]INST_SHL;
	wire [31:0]PC_ADD4;
	wire [31:0]JUMP_ADDR;
	wire [31:0]PC_NEXT;
	wire [31:0]SIGN_EXTNUM_SHL;
	
	wire [31:0]ALU2_RESULT;
	wire [31:0]PC_NEXT_PRE;
	//
	
	wire [31:0]INST;

	
	reg [31:0] PC;
	//wire PC_NEXT;
	wire PC_SRC;

	assign ALU_IN2 = ID_ALU_SRC ? SIGN_EXTNUM : READ_DATA2;//
	assign WRITE_REG = ID_REG_DST ? INST[15:11] : INST[20:16];//
	assign WRITE_DATA = 	ID_MEM_TO_REG ? READ_DATA : ALU_RESULT;//
	assign PC_NEXT_PRE = (ID_BRANCH & ALU_OUT_ZERO) ? ALU2_RESULT : PC_ADD4;//
	assign PC_NEXT = ID_JUMP ? JUMP_ADDR : PC_NEXT_PRE;
	assign IF_ALU_OP = ID_EX_ALUOP;
	
	assign INST_SHL = INST[25:0]<<2;
	assign PC_ADD4 = PC + 4;
	assign JUMP_ADDR = {PC_ADD4[31:28],INST_SHL};
	assign SIGN_EXTNUM_SHL = SIGN_EXTNUM<<2;
	assign ALU2_RESULT = PC_ADD4 + SIGN_EXTNUM_SHL;
	
	//1.0 IF -> ID

	reg [31:0] IF_ID_PC_ADD4;
	reg [31:0] IF_ID_INST;
	
	//2.0 ID -> EX
	
	reg [31:0] ID_EX_PC_ADD4;
	reg [31:0] ID_EX_READ_DATA1;
	reg [31:0] ID_EX_READ_DATA2;
	reg [31:0] ID_EX_SIGN_EXTNUM;
	reg [20:16] ID_EX_INSTHigh;
	reg [15:11] ID_EX_INSTLow;

	reg ID_EX_REG_DST;
	reg ID_EX_BRANCH;
	reg ID_EX_MEM_READ;
	reg ID_EX_MEM_TO_REG;
	reg ID_EX_MEM_WRITE;
	reg [1:0] ID_EX_ALUOP;
	reg ID_EX_ALU_SRC;
	reg ID_EX_REG_WRITE;

	//3.0 EX -> MEM
	reg [31:0] EX_MEM_PC_ADD4;
	reg [31:0] EX_MEM_READ_DATA2;
	reg EX_MEM_ALU_OUT_ZERO;
	reg [4:0]EX_MEM_WRITE_REG;
	reg [31:0]EX_MEM_ALU_RESULT;
	
	reg EX_MEM_BRANCH;
	reg EX_MEM_MEM_READ;
	reg EX_MEM_MEM_TO_REG;
	reg EX_MEM_MEM_WRITE;
	reg EX_MEM_REG_WRITE;
	
	//4.0 MEM to WB
	reg [31:0] MEM_WB_ALU_RESULT;
	reg [31:0] MEM_WB_READ_DATA;
	reg [4:0] MEM_WB_WRITE_REG;
	reg MEM_WB_REG_WRITE;
	reg MEM_WB_MEM_TO_REG;
	
	initial 
	begin
	PC = 0;
 
	IF_ID_PC_ADD4 = 0;
	IF_ID_INST = 0;
 
	ID_EX_PC_ADD4 = 0;
	ID_EX_READ_DATA1 = 0;
	ID_EX_READ_DATA2 = 0;
	ID_EX_SIGN_EXTNUM = 0;
	ID_EX_INSTHigh = 0;
	ID_EX_INSTLow = 0;
	ID_EX_REG_DST = 0;
	ID_EX_BRANCH = 0;
	ID_EX_MEM_READ = 0;
	ID_EX_MEM_TO_REG = 0;
	ID_EX_MEM_WRITE = 0;
	ID_EX_ALUOP = 0;
	ID_EX_ALU_SRC = 0;
	ID_EX_REG_WRITE = 0;

	EX_MEM_PC_ADD4 = 0;
	EX_MEM_READ_DATA2 = 0;
	EX_MEM_ALU_OUT_ZERO = 0;
	EX_MEM_WRITE_REG = 0;
	EX_MEM_ALU_RESULT = 0;
	EX_MEM_BRANCH = 0;
	EX_MEM_MEM_READ = 0;
	EX_MEM_MEM_TO_REG = 0;
	EX_MEM_MEM_WRITE = 0;
	EX_MEM_REG_WRITE = 0;
	
	MEM_WB_ALU_RESULT = 0;
	MEM_WB_READ_DATA = 0;
	MEM_WB_WRITE_REG = 0;
	MEM_WB_REG_WRITE = 0;
	MEM_WB_MEM_TO_REG = 0;
	end

	assign PC_NEXT = PC_SRC ? EX_MEM_PC_ADD4 : (PC + 4); 
	
	
	InstructionMemory mainIM(
		.address(PC),
		.CLK(clk),
		.RESET(reset),
		.readData(INST)
	);
	
	Ctr mainCtr(
			.opCode(IF_ID_INST[31:26]),
			.regDst(ID_REG_DST),
			.jump(ID_JUMP),
			.branch(ID_BRANCH),
			.memRead(ID_MEM_READ),
			.memToReg(ID_MEM_TO_REG),
			.aluOp(ID_ALU_OP),
			.memWrite(ID_MEM_WRITE),
			.aluSrc(ID_ALU_SRC),
			.regWrite(ID_REG_WRITE)
			);	
			
	aluCtrOut mainAluCtr(
			.aluOp(IF_ALU_OP),
			.funct(INST[5:0]),
			.aluCtr(ALU_CTR)
		);		

	register mainRegister(
			.clock_in(clk),
			.readReg1(INST[25:21]),
			.readReg2(INST[20:16]),
			.writeReg(WRITE_REG),
			.writeData(WRITE_DATA),
			.regWrite(ID_REG_WRITE),
			.reset(reset),
			.readData1(READ_DATA1),
			.readData2(READ_DATA2)
	);
	
	
	always @(posedge clk)
	begin
		if(reset == 1)
		begin
			PC<=0;
			IF_ID_PC_ADD4 = 0;
			IF_ID_INST = 0;
		 
			ID_EX_PC_ADD4 = 0;
			ID_EX_READ_DATA1 = 0;
			ID_EX_READ_DATA2 = 0;
			ID_EX_SIGN_EXTNUM = 0;
			ID_EX_INSTHigh = 0;
			ID_EX_INSTLow = 0;
			ID_EX_REG_DST = 0;
			ID_EX_BRANCH = 0;
			ID_EX_MEM_READ = 0;
			ID_EX_MEM_TO_REG = 0;
			ID_EX_MEM_WRITE = 0;
			ID_EX_ALUOP = 0;
			ID_EX_ALU_SRC = 0;
			ID_EX_REG_WRITE = 0;

			EX_MEM_PC_ADD4 = 0;
			EX_MEM_READ_DATA2 = 0;
			EX_MEM_ALU_OUT_ZERO = 0;
			EX_MEM_WRITE_REG = 0;
			EX_MEM_ALU_RESULT = 0;
			EX_MEM_BRANCH = 0;
			EX_MEM_MEM_READ = 0;
			EX_MEM_MEM_TO_REG = 0;
			EX_MEM_MEM_WRITE = 0;
			EX_MEM_REG_WRITE = 0;
			
			MEM_WB_ALU_RESULT = 0;
			MEM_WB_READ_DATA = 0;
			MEM_WB_WRITE_REG = 0;
			MEM_WB_REG_WRITE = 0;
			MEM_WB_MEM_TO_REG = 0;
		end
		else
			PC<=PC_NEXT;
		//IF_ID
		IF_ID_PC_ADD4<=PC_ADD4;
		IF_ID_INST <= INST;
		//ID_EX
		ID_EX_REG_DST <= 
		
	end


endmodule
*/
