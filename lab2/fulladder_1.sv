//  1 bit full adder
module fulladder_1(A, B, C_in, C_out, S);

	input logic A, B, C_in;
	output logic C_out, S;
	logic w1, w2, w3;

	xor #50 xor1(w1, A, B);
	xor #50 xor2(S, C_in, w1);
	
	and #50 and1(w2, C_in, w1);
	and #50 and2(w3, A, B);
	
	or #50 or1(C_out, w2, w3);

endmodule
