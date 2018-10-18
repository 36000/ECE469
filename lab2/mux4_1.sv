//  4 to 1 mux
module mux4_1(out, in, select);

	input logic [3:0] in;
	input logic [1:0] select;
	output logic out;
	logic w1, w2;

	mux2_1 mux0 (w1, in[0], in[1], select[0]);
	mux2_1 mux1 (w2, in[2], in[3], select[0]);
	
	mux2_1 mux2 (out, w1, w2, select[1]);

endmodule
