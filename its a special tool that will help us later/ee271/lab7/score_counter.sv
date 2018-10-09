module score_counter (win, clk, reset, HEX);
	input logic win, clk, reset;
	output logic [6:0] HEX;
	
	logic [2:0] ps;

	always_ff @(posedge clk) begin
		if (reset) ps <= 3'b0;
		else if (win) ps <= ps + 3'b001;
		else ps <= ps;
	end
	
	always_comb begin
		case (ps) 
			//    Light: 6543210 
			3'b000: HEX = ~7'b0111111; // 0 
			3'b001: HEX = ~7'b0000110; // 1 
			3'b010: HEX = ~7'b1011011; // 2 
			3'b011: HEX = ~7'b1001111; // 3 
			3'b100: HEX = ~7'b1100110; // 4 
			3'b101: HEX = ~7'b1101101; // 5 
			3'b110: HEX = ~7'b1111101; // 6 
			3'b111: HEX = ~7'b0000111; // 7 
			default: HEX = ~7'b0; // display off
		endcase 
	
	end
	

endmodule



module score_counter_testbench();
	logic win, clk, reset;
	logic [6:0] HEX;
	
	
	score_counter dut (.win, .clk, .reset, .HEX);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	initial begin
		reset <= 1; win <= 0; 	@(posedge clk);
		reset <= 0; 				@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		win <= 1;					@(posedge clk);
		win <= 0;					@(posedge clk);
		
		$stop;
		
	end
	
endmodule