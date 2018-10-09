// Michael Humphrey
module play_light (out_light, inL, inR, neighborL, neighborR, is_center, clk, reset);
	input logic inL, inR, neighborL, neighborR, is_center, clk, reset;
	output logic out_light;
	
	enum { ON, OFF} ps, ns; // ON = light currently on, OFF = light currently off
	logic temp_light;
	
	always_comb begin
		case (ps)
			
			ON: if ((inL && inR) || (~inL && ~inR)) begin
					temp_light = 1;
					ns = ON; end
				else begin
					temp_light = 0;
					ns = OFF; end
					
			OFF: if ((inL && neighborR && ~inR) || (inR && neighborL && ~inL)) begin
					temp_light = 1;
					ns = ON; end
				else begin
					temp_light = 0;
					ns = OFF; end
					
		endcase
		
	end
	
	always_ff @(posedge clk) begin 
		if (reset) begin
			if (is_center) begin
				ps <= ON; 
				out_light <= 1; end
			else begin
				ps <= OFF;
				out_light <= 0; end
		end
			
		else 
			ps <= ns; begin
			out_light <= temp_light; end
	end  
	
endmodule  



module play_light_testbench();
	logic inL, inR, nL, nR, is_center, clk, reset;
	logic out_light;
	
	play_light dut (.out_light, .inL, .inR, .neighborL(nL), .neighborR(nR), .is_center, .clk, .reset);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
	is_center<=0;						@(posedge clk); 
	reset<=1;							@(posedge clk); 
	reset<=0; inL<=0;inR<=0;nL<=0;nR<=0;		@(posedge clk);
					inL<=1;				@(posedge clk);
					inL<=0;				@(posedge clk); 
					inL<=1;nR<=1;		@(posedge clk);  
					inL<=0;nR<=0;		@(posedge clk); 
											@(posedge clk); 
					inR<=1;nR<=1;		@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
	is_center<=1;						@(posedge clk); 
	reset<=1;							@(posedge clk); 
	reset<=0; inL<=0;inR<=0;nL<=0;nR<=0;		@(posedge clk);
					inL<=1;				@(posedge clk);
					inL<=0;				@(posedge clk); 
					inL<=1;nR<=1;		@(posedge clk);  
					inL<=0;nR<=0;		@(posedge clk); 
											@(posedge clk); 
					inR<=1;nR<=1;		@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
											
		$stop; // End the simulation.  
	end 
	
endmodule