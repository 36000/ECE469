module register_64 (out, in, write, reset, clk);
	output logic [63:0] out;
	input logic [63:0] in;
	input logic write, reset, clk;
	
	generate
		for(i=0; i<64; i++) begin : bits
			register_1 reg_1 (out[i], in[i], write, reset, clk);
		end
	endgenerate
	
endmodule

