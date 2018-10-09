//  2 to 1 mux
module mux2_1(out, in0, in1, select);

	input logic in0, in1, select;
	output logic out;
	logic s_bar, w1, w2;

	not not1(s_bar, select);

	and and1(w1, s_bar, in0);
	and and2(w2, select, in1);

	or or1(out, w1, w2);

endmodule
