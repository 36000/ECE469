// Michael Humphrey
module input_blink (out, in, clk, reset);
	input logic in, clk, reset;
	output logic out;
	
	enum { D, H} ps, ns; // D = default off, H = holding on
	always_comb begin
		case (ps)
			
			D: if (in) begin
					out = 1;
					ns = H; end
				else begin
					out = 0;
					ns = D; end
					
			H: if (in) begin
					out = 0;
					ns = H; end
				else begin
					out = 0;
					ns = D; end
					
		endcase
		
	end
	
	always_ff @(posedge clk) begin 
		if (reset)  
			ps <= D; 
		else  
			ps <= ns;  
	end  
	
endmodule  


module input_blink_testbench();
	logic clk, reset;
	logic in, out;
	
	input_blink dut (.out, .in, .clk, .reset);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
								@(posedge clk); 
		reset<=1;			@(posedge clk); 
		reset<=0; in<=0;	@(posedge clk);
								@(posedge clk);
								@(posedge clk); 
					 in<=1;	@(posedge clk);  
								@(posedge clk); 
								@(posedge clk); 
					 in<=0;	@(posedge clk); 
								@(posedge clk); 
								@(posedge clk); 
											
		$stop; // End the simulation.  
	end 
	
endmodule