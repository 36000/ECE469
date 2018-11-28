`timescale 1ns/10ps

module MEM(Dw, logic_result, Db, instr, controlsigs, clk);
	output logic [63:0] Dw;

	input logic [63:0] logic_result, Db;
	input logic [31:0] instr;
	input logic [13:0] controlsigs;
	input logic clk;

	logic [63:0] mem_out;
	
	logic MemWrite; logic MemToReg;
	assign MemWrite = controlsigs[9];
	assign MemToReg = controlsigs[11];
	
	datamem Memory (.address(logic_result), .write_enable(MemWrite), .read_enable(MemToReg), .write_data(Db), .clk, .xfer_size(4'b1000), .read_data(mem_out));
	
	mux64x2_1 choose_MemToReg(Dw, logic_result, mem_out, MemToReg);
endmodule