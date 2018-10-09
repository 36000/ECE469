// Lab 8: Elevator
// Michael Humphrey 3/6/2018 SID:1536326
module myDFF_6b (Q, D, clk, reset);
	input  logic clk, reset;
	input  logic [5:0] D;
	output logic [5:0] Q;
	
	always_ff @(posedge clk) begin 
		if (reset)  
			Q <= 6'b0; 
		else  
			Q <= D;  
	end  
	
endmodule   
