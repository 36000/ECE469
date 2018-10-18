//  1 bit full adder
module fulladder_1(in, C_in, C_out, S);

	input logic C_in;
	input logic [1:0] in;
	output logic C_out, S;
	logic w1, w2, w3;

	xor #50 xor1(w1, in[0], in[1]);
	xor #50 xor2(S, C_in, w1);
	
	and #50 and1(w2, C_in, w1);
	and #50 and2(w3, in[0], in[1]);
	
	or #50 or1(C_out, w2, w3);

endmodule
