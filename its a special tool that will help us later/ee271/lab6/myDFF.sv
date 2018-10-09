// Michael Humphrey
module myDFF (Q, D, clk, reset);
	input  logic D, clk, reset;
	output logic Q;
	
	always_ff @(posedge clk) begin 
		if (reset)  
			Q <= 1'b0; 
		else  
			Q <= D;  
	end  
	
endmodule   


module myDFF_testbench();
	logic clk, reset;
	logic D;
	logic Q;
	
	myDFF dut (Q, D, clk, reset);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
									@(posedge clk); 
		reset <= 1;				@(posedge clk); 
		reset <= 0; D <= 0;	@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); 
						D <= 1;	@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); 

		$stop; // End the simulation.  
	end 
	
endmodule