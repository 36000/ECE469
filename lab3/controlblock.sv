enum integer {Reg2Loc=0, ALUSrc=1, MemToReg=2, RegWrite=3, MemWrite=4, BrTaken=5, UncondBr=6, ALUOp1=7, ALUOp2=8, ALUOp3=9} signal;
enum logic[10:0] {ADDI=11'b'1001000100x, ADDS=1, AND=2, B=3, B_LT=4, CBZ=5, EOR=6, LDUR=7, LSR=8, STUR=9, SUBS=10} instruction;
parameter controlsigs_size = 10;

// control block
module controlblock(controlsigs, instr);
	input logic [10:0] instr;
	output logic [controlsigs_size-1:0] controlsigs;

	always_comb begin
		case(instr)
			ADDI: controlsigs = controlsigs_size'b100100X+;
			default: controlsigs = controlsigs_size'b0;
		endcase
	end
	
endmodule
