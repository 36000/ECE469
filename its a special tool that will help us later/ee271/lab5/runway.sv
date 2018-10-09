module runway (clk, reset, in, out);  
	input  logic  clk, reset;
	input  logic  [1:0] in;
	output logic  [2:0] out; 

	// Define light states
	enum { L, M, R, D} ps, ns; 
	always_comb begin
		case (ps)
		
			L: if ((in == 2'b00) || (in == 2'b10)) begin
					ns = M;
					out = 3'b010;
					end
				else begin // (in == 2'b01)
					ns = R;
					out = 3'b001;
					end
				
			M: if (in == 2'b00) begin
					ns = D;
					out = 3'b101;
					end
				else if (in == 2'b01) begin
					ns = L;
					out = 3'b100;
					end
				else begin // (in == 2'b10)
					ns = R;
					out = 3'b001;
					end
				
			R: if ((in == 2'b00) || (in == 2'b01)) begin
					ns = M;
					out = 3'b010;
					end
				else begin // (in == 2'b10)
					ns = L;
					out = 3'b100;
					end
					
			D: begin
				ns = M;
				out = 3'b010;
				end
								
		endcase
		
	end
	
	always_ff @(posedge clk) begin 
		if (reset)  
			ps <= M; 
		else  
			ps <= ns;  
	end  
	
endmodule   


module runway_testbench();  
	logic  clk, reset;
	logic  [1:0] in; 
	logic  [2:0] out;  
	
	runway dut (clk, reset, in, out);  
	
	// Set up the clock.  
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
										@(posedge clk); 
		reset <= 1;					@(posedge clk); 
		reset <= 0; in <= 2'b00; @(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
						in <= 2'b01;	@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
						in <= 2'b10;	@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
										@(posedge clk); 
		$stop; // End the simulation.  
	end 
	
endmodule 