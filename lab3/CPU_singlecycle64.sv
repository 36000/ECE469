

module CPU_singlecycle64(reset, clk);
	input logic reset, clk;
	
	logic [63:0] PC;
	logic [31:0] instr;
	
	logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, 
	      BrTaken, UncondBr, ALUOp2, ALUOp1, ALUOp0,
		  BigImm, Shift, SetFlag, isLTnotCBZ;
		  
	logic [4:0] Rd, Rm, Rn;
	logic [5:0] shamt;
	logic [8:0] Imm9; logic [11:0] Imm12; logic [18:0] Imm19; logic [25:0] Imm26;
	
	logic negative, zero, overflow, carry_out,
	      negative_ub, zero_ub, overflow_ub, carry_out_ub;
	
	// controls and inputs
	
	controlblock ControlBlock ({Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, 
								BrTaken, UncondBr, ALUOp2, ALUOp1, ALUOp0,
								BigImm, Shift, SetFlag, isLTnotCBZ}, instr);
								
	assign Rd = instr[4:0];
	assign Rm = instr[20:16];
	assign Rn = instr[9:5];
	assign shamt = instr[15:10];
	assign Imm9 = instr[20:12];
	assign Imm12 = instr[21:10];
	assign Imm19 = instr[23:5];
	assign Imm26 = instr[25:0];
	
	// instruction part
	logic [63:0] SE_Imm19, SE_Imm26, SE_Imm, SE_Imm_SHFT, new_incremented_PC, new_branch_PC, new_PC, PC_select;
	
	register_64 PCcontrol (PC, new_PC, 1'b1, reset, clk);
	instructmem InstructionMemory (PC, instr, clk);
	
	SE_64 Imm19_extender #(input_size = 19;) (.out(SE_Imm19), .in(Imm19));
	SE_64 Imm26_extender #(input_size = 26;) (.out(SE_Imm26), .in(Imm26));
	
	mux64x2_1 choose_break (SE_Imm, SE_Imm19, SE_Imm26, UncondBr);
	LSL_2 branch_offset_shifter (SE_Imm_SHFT, SE_Imm);
	
	alu incrementPC(.A(PC), .B(64'd4), .cntrl(3'b010), .result(new_incremented_PC), .negative(), .zero(), .overflow(), .carry_out());
	alu branchPC(.A(SE_Imm_SHFT), .B(PC), .cntrl(3'b010), .result(new_branch_PC), .negative(), .zero(), .overflow(), .carry_out());
	
	mux64x2_1 choose_PC (new_PC, new_incremented_PC, new_branch_PC, PC_select);
	
	// flag part
	logic CBZ, BLT, CondBrTaken;
	
	flagfile({negative, zero, overflow, carry_out}, .CBZ, .BLT, negative_ub, zero_ub, overflow_ub, carry_out_ub, .reset, .enable(SetFlag));
	
	mux2_1 choose_cond_br(CondBrTaken, CBZ, BLT, isLTnotCBZ);
	mux2_1 choose_br(PC_select, CondBrTaken, BrTaken, UncondBr);
	
	// reg part
	logic Ab, Da, Db;
	
	mux64x2_1 choose_Reg2Loc(Ab, Rd, Rn, Reg2Loc);
	
	
	
	// ALU part
	
	// mem part
	

endmodule