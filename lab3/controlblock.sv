

parameter controlsigs_size = 14;
enum integer {Reg2Loc=0, ALUSrc=1, MemToReg=2, RegWrite=3, MemWrite=4, 
			  BrTaken=5, UncondBr=6, ALUOp2=7, ALUOp1=8, ALUOp0=9,
			  BigImm=10, Shift=11, SetFlag=12, isLTnotCBZ=13} signal;
			  
enum logic[10:0] {ADDI=11'b1001000100Z, ADDS=11'b10101011000, AND=11'b10001010000, 
				  B=11'b000101ZZZZZ, B_LT=11'b01010100ZZZ, CBZ=11'b10110100ZZZ, 
				  EOR=11'b11001010000, LDUR=11'b11111000010, LSR=11'b11010011010, 
				  STUR=11'b11111000000, SUBS=11'b11101011000} instruction;

// control block
module controlblock(controlsigs, instr);
	input logic [10:0] instr;
	output logic [controlsigs_size-1:0] controlsigs;

	always_comb begin
		casez(instr)
			ADDI: controlsigs = controlsigs_size'b110100X010100X;
			ADDS: controlsigs = controlsigs_size'b100100X010X01X;
			AND:  controlsigs = controlsigs_size'b100100X100X00X;
			B:    controlsigs = controlsigs_size'bXXX0011XXXXX0X;
			B_LT: controlsigs = controlsigs_size'bXXX0010XXXXX01;
			CBZ:  controlsigs = controlsigs_size'bXXX0010XXXXX00;
			EOR:  controlsigs = controlsigs_size'b100100X110X00X;
			LDUR: controlsigs = controlsigs_size'bX11100X010000X;
			LSR:  controlsigs = controlsigs_size'bXX0100XXXXX10X;
			STUR: controlsigs = controlsigs_size'b01X010X010000X;
			SUBS: controlsigs = controlsigs_size'b100100X011X01X;
			default: controlsigs = controlsigs_size'bXXX000XXXXXX0X;
		endcase
	end
	
endmodule