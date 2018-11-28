`timescale 1ns/10ps

module EX(logic_result, PC_select,
		  Da, Db, instr, controlsigs, clk, reset);
	output logic [63:0] logic_result;
	output PC_select;
	input logic [63:0] Da, Db;
	
	input clk, reset;
	
	input logic [31:0] instr;
	input logic [13:0] controlsigs;
	logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, 
	      BrTaken, UncondBr, ALUOp2, ALUOp1, ALUOp0,
		  BigImm, Shift, SetFlag, isLTnotCBZ;							
	assign {Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, 
		  BrTaken, UncondBr, ALUOp2, ALUOp1, ALUOp0,
		  BigImm, Shift, SetFlag, isLTnotCBZ} = controlsigs;
		  
	logic [5:0] shamt; logic [8:0] Imm9; logic [11:0] Imm12;
	assign shamt = instr[15:10];
	assign Imm9 = instr[20:12];
	assign Imm12 = instr[21:10];
		  
	logic [63:0] SE_Imm9, UE_Imm12, ALU_Imm, ALU_B, ALU_out, SHFT_out;
	logic negative, zero, overflow, carry_out,
          negative_ub, zero_ub, overflow_ub, carry_out_ub;
	
	SE_64 #(9) Imm9_extender (.out(SE_Imm9), .in(Imm9));
	UE_64 #(12) Imm12_extender (.out(UE_Imm12), .in(Imm12));
	
	mux64x2_1 choose_Immediate(ALU_Imm, SE_Imm9, UE_Imm12, BigImm);
	mux64x2_1 choose_ALUsrc(ALU_B, Db, ALU_Imm, ALUSrc);
	
	alu alu_execute(Da, ALU_B, {ALUOp2, ALUOp1, ALUOp0}, ALU_out, negative_ub, zero_ub, overflow_ub, carry_out_ub);
	
	shifter right_shifter(Da, 1'b1 /*direction is right*/, shamt, SHFT_out);
	mux64x2_1 choose_result(logic_result, ALU_out, SHFT_out, Shift);
	
	logic CBZ, BLT;
	logic CondBrTaken;
	
	flagfile FlagFile ({negative, zero, overflow, carry_out}, CBZ, BLT, negative_ub, zero_ub, overflow_ub, carry_out_ub, reset, SetFlag, clk);
	
	mux2_1 choose_cond_br(CondBrTaken, CBZ, BLT, isLTnotCBZ);
	mux2_1 choose_br(PC_select, CondBrTaken, BrTaken, UncondBr);
	
endmodule