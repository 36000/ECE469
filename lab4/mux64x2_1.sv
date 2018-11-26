module mux64x2_1 (out, in0, in1, select);
output logic [63:0] out;
input logic [63:0] in0, in1;
input logic select;

genvar i;
generate
	for(i=0; i<64; i++) begin : muxs
		mux2_1 muxx (out[i], in0[i], in1[i], select);
	end
endgenerate

endmodule
