//  8 to 1 mux
module mux8_1(out, in, select);

	input logic [7:0] in;
	input logic [2:0] select;
	output logic out;
	logic w1, w2;

	mux4_1 mux0 (w1, in[3:0], select[1:0]);
	mux4_1 mux1 (w2, in[7:4], select[1:0]);
	
	mux2_1 mux2 (out, w1, w2, select[2]);

endmodule
