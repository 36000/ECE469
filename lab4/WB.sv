`timescale 1ns/10ps

module WB(Rd, RegWrite, instr, controlsigs);
	output logic [4:0] Rd;
	output logic RegWrite;
	
	input logic [31:0] instr;
	input logic [13:0] controlsigs;
	
	assign Rd = instr[4:0];
	assign RegWrite = controlsigs[10];
endmodule