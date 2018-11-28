`timescale 1ns/10ps
// Width N Register
module register_N (out, in, write, reset, clk);
parameter DATA_WIDTH = 64;

	output logic [DATA_WIDTH-1:0] out;
	input logic [DATA_WIDTH-1:0] in;
	input logic write, reset, clk;
	
	genvar i;
	generate
		for(i=0; i<DATA_WIDTH; i++) begin : bits
			register_1 reg_1 (out[i], in[i], write, reset, clk);
		end
	endgenerate
	
endmodule

