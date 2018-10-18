//  1 bit ALU
module ALU_1(A, B, C_in, sub, cntrl, C_out, S);

	input logic A, B, C_in, sub;
	input logic [2:0] cntrl;
	output logic C_out, S;
	logic outs[7:0];
	
	assign outs[0] = B;
	and #50 and1(outs[4], A, B);
	or #50 or1(outs[5], A, B);
	xor #50 xor1(outs[6], A, B);

	fulladdsub_1 fas1({A, B}, sub, C_in, C_out, outs[2]);
	assign outs[3] = outs[2];
	
	mux8_1(S, outs, cntrl);
	
endmodule
