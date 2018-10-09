// Michael Humphrey
module input_buffer (outL, outR, inL, inR, clk, reset);
	input  logic inL, inR, clk, reset;
	output logic outL, outR;
	
//	// Buffers the inputs with two DFFs for each one
//	logic tempL, tempR, buffL, buffR;
//	myDFF dff1 (tempL, inL, clk, reset); // want the inputs to be buffered by two dffs
//	myDFF dff2 (buffL, tempL, clk, reset);
//	
//	myDFF dff3 (tempR, inR, clk, reset);
//	myDFF dff4 (buffR, tempR, clk, reset);
//
//	
//	// Determines the correct output behavior
//	always_ff @(posedge clk) begin 
//		// maybe change xor here to fix bug?
//		if (reset || ~(buffL ^ buffR))  begin // If reset is true or both inputs are the same
//			outL <= 0;
//			outR <= 0; end
//		else  if (buffL) begin
//			outL <= 1;
//			outR <= 0; end
//		else begin
//			outL <= 0;
//			outR <= 1; end
//	end  
	logic tempL, tempR;
	myDFF dff1 (tempL, inL, clk, reset); // want the inputs to be buffered by two dffs
	myDFF dff2 (outL, tempL, clk, reset);
	
	myDFF dff3 (tempR, inR, clk, reset);
	myDFF dff4 (outR, tempR, clk, reset);
	
endmodule   


module input_buffer_testbench();
	logic clk, reset;
	logic inL, inR;
	logic outL, outR;
	
	input_buffer dut (.outL, .outR, .inL, .inR, .clk, .reset);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
											@(posedge clk); 
		reset<=1;						@(posedge clk); 
		reset<=0; inL<=0; inR<=0;	@(posedge clk); 
					 inL<=1; inR<=0;	@(posedge clk); 
					 inL<=0; inR<=0;	@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
					 inL<=1; inR<=0;	@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
					 inL<=1; inR<=1;	@(posedge clk); 
											@(posedge clk); 
											@(posedge clk); 
											@(posedge clk);
					 inL<=0; inR<=1;	@(posedge clk);	
											@(posedge clk); 
											@(posedge clk); 	
											@(posedge clk); 
					 inL<=0; inR<=0;	@(posedge clk);	
											@(posedge clk); 
											@(posedge clk); 	
											@(posedge clk); 
											
		$stop; // End the simulation.  
	end 
	
endmodule