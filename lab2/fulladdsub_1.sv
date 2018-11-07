`timescale 1ns/10ps

//  1 bit full adder with sub signal
module fulladdsub_1(in, sub, C_in, C_out, S);

	input logic sub, C_in;
	input logic [1:0] in;
	output logic C_out, S;
	logic in0_bar, w0;

	not #50 not1(in0_bar, in[0]);
	mux2_1 mux1(w0, in[0], in0_bar, sub);
	
	fulladder_1 fa1({in[1], w0}, C_in, C_out, S);

endmodule
