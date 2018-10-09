module LFSR_10bit (out, reset, clk);
	output logic [9:0] out;
	input logic reset, clk;
	
	logic [9:0] ns, ps;
	logic temp;
	always_comb begin
		temp = (ps[6] ^~ ps[9]);
		ns = { ps[8:0], temp};
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= 10'b0;
			out <= 1'b0;
		end
		else begin
			ps <= ns;
			out <= ns;
		end
	end
	
endmodule


module LFSR_10bit_testbench();
	logic out, reset, clk;
	
	LFSR_10bit dut (.out, .reset, .clk);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		#10000;
		
		$stop;
		
	end
	
endmodule
