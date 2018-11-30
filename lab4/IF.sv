`timescale 1ns/10ps

module IF(instr, PC, PC_select_b, PC_select_ub, BrTaken, controlsigs, reset, clk);
	input logic reset, clk, BrTaken;

	input logic PC_select_b, PC_select_ub;
	input logic [13:0] controlsigs;
	
	output logic [63:0] PC;
	output logic [31:0] instr;

	logic [63:0] SE_Imm19, SE_Imm26, SE_Imm, SE_Imm_SHFT, new_incremented_PC, new_branch_PC, new_PC;
	logic PC_select, BrTaken;
	
	logic [18:0] Imm19; logic [25:0] Imm26; logic UncondBr;
	assign Imm19 = instr[23:5];
	assign Imm26 = instr[25:0];
	assign UncondBr = controlsigs[7];
	
	mux2_1 branch_forwarder(PC_select, PC_select_b, PC_select_ub, BrTaken);
	
	register_64 PCcontrol (PC, new_PC, 1'b1, reset, clk);
	instructmem InstructionMemory (PC, instr, clk);
	
	SE_64 #(19) Imm19_extender (.out(SE_Imm19), .in(Imm19));
	SE_64 #(26) Imm26_extender (.out(SE_Imm26), .in(Imm26));
	
	mux64x2_1 choose_break (SE_Imm, SE_Imm19, SE_Imm26, UncondBr);
	LSL_2 branch_offset_shifter (SE_Imm_SHFT, SE_Imm);
	
	alu incrementPC(.A(PC), .B(64'd4), .cntrl(3'b010), .result(new_incremented_PC), .negative(), .zero(), .overflow(), .carry_out());
	alu branchPC(.A(SE_Imm_SHFT), .B(PC), .cntrl(3'b010), .result(new_branch_PC), .negative(), .zero(), .overflow(), .carry_out());
	
	mux64x2_1 choose_PC (new_PC, new_incremented_PC, new_branch_PC, PC_select);
	
endmodule