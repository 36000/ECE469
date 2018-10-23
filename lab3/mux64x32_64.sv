module mux64x32_64 (out, in, select);
output logic [63:0] out;
input logic [63:0] [31:0] in;
input logic [4:0] select;

genvar i;
generate
	for(i=0; i<64; i++) begin : muxs
		mux32_1 muxx (out[i], in[i], select);
	end
endgenerate

endmodule
