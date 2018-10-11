module register_1 (out, in, write_enable, reset, clk);

	output logic out;
	input logic in, write_enable, reset, clk;
	logic w1;
	
	mux2_1 mux0 (w1, out, in, write_enable);
	D_FF dff0 (out, w1, reset, clk);
	
endmodule

module register_1_testbench();
		logic out, in, write_enable, reset, clk;
		
		parameter ClockDelay = 5000;
		initial begin // Set up the clock
			clk <= 0;
			forever #(ClockDelay/2) clk <= ~clk;
		end
		
		register_1 dut (.out, .in, .write_enable, .reset, .clk);
		
		initial begin
				in <=0; write_enable<=0; reset<=1; @(negedge clk);
				in <=1; write_enable<=0; reset<=0; @(negedge clk);
				in <=1; write_enable<=1; reset<=0; @(negedge clk);
				in <=0; write_enable<=0; reset<=0; @(negedge clk);
				in <=0; write_enable<=0; reset<=1; @(negedge clk);
				in <=1; write_enable<=1; reset<=0; @(negedge clk);
				in <=1; write_enable<=1; reset<=1; @(negedge clk);
				$stop;
		end
endmodule
