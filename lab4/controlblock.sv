

// controlsigs should be 14 bits wide, because 14 control signals (shown directly below this comment)
// enum integer {Reg2Loc=0, ALUSrc=1, MemToReg=2, RegWrite=3, MemWrite=4, 
// 			  BrTaken=5, UncondBr=6, ALUOp2=7, ALUOp1=8, ALUOp0=9,
// 			  BigImm=10, Shift=11, SetFlag=12, isLTnotCBZ=13} signal;
			  
enum logic[10:0] {ADDI=11'b1001000100Z, ADDS=11'b10101011000, AND=11'b10001010000, 
				  B=11'b000101ZZZZZ, B_LT=11'b01010100ZZZ, CBZ=11'b10110100ZZZ, 
				  EOR=11'b11001010000, LDUR=11'b11111000010, LSR=11'b11010011010, 
				  STUR=11'b11111000000, SUBS=11'b11101011000} instruction;

// control block
module controlblock(controlsigs, instr);
	input logic [10:0] instr;
	output logic [14-1:0] controlsigs;

	always_comb begin
		casez(instr)
			ADDI: controlsigs = 14'b1101001010100X;
			ADDS: controlsigs = 14'b1001001010X01X;
			AND:  controlsigs = 14'b1001001100X00X;
			B:    controlsigs = 14'bXXX0011XXXXX0X;
			B_LT: controlsigs = 14'bXXX0010XXXXX01;
			CBZ:  controlsigs = 14'b00X0010000XX00;
			EOR:  controlsigs = 14'b1001001110X00X;
			LDUR: controlsigs = 14'bX111001010000X;
			LSR:  controlsigs = 14'bXX01001XXXX10X;
			STUR: controlsigs = 14'b01X0101010000X;
			SUBS: controlsigs = 14'b1001001011X01X;
			default: controlsigs = 14'bXXX0001XXXXX0X;
		endcase
	end
	
endmodule
