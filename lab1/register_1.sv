module register_1 (out, in, write, reset, clk);

	output logic out;
	input logic in, write, reset, clk;
	logic w1;
	
	mux2_1 mux0 (w1, out, in, write);
	D_FF dff0 (out, w1, reset, clk);
	
endmodule

module register_1_testbench();
		logic out, in, write, reset, clk
		
		parameter ClockDelay = 5000;
		initial begin // Set up the clock
			clk <= 0;
			forever #(ClockDelay/2) clk <= ~clk;
		end
		
		register_1 dut (.out, .in, .write, .reset, .clk);
		
		initial begin
				in <=0, write<=0, reset<=1 @(posedge clk);
				in <=1, write<=0, reset<=0 @(posedge clk);
				in <=1, write<=1, reset<=0 @(posedge clk);
				in <=0, write<=0, reset<=0 @(posedge clk);
				in <=0, write<=0, reset<=1 @(posedge clk);
				in <=1, write<=1, reset<=0 @(posedge clk);
				in <=1, write<=1, reset<=1 @(posedge clk);
		end
endmodule
