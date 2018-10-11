module register_1 (out, in, write, reset, clk);

	output logic out;
	input logic in, write, reset, clk;
	logic w1;
	
	mux2_1 mux0 (w1, out, in, write);
	D_FF dff0 (out, w1, reset, clk);
	
endmodule
