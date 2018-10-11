//  4 to 1 mux
module mux4_1(out, in00, in01, in10, in11, select1, select0);

	input logic in00, in01, in10, in11, select1, select0;
	output logic out;
	logic w1, w2;

	mux2_1 mux0 (w1, in00, in01, select0);
	mux2_1 mux1 (w2, in10, in11, select0);
	
	mux2_1 mux2 (out, w1, w2, select1);

endmodule
