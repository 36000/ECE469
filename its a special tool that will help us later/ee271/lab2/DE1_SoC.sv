// Top-level module that defines the I/Os for the DE-1 SoC board  
// Michael Humphrey 1/16/2018 SID:1536326
 
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);  
	output logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;  
	output logic  [9:0]    LEDR;   
	input  logic  [3:0]    KEY;    
	input  logic  [9:0]   SW;   
	 
	// Default values, turns off the HEX displays 
	assign HEX0 = 7'b1111111;   
	assign HEX1 = 7'b1111111;   
	assign HEX2 = 7'b1111111;   
	assign HEX3 = 7'b1111111;   
	assign HEX4 = 7'b1111111;   
	assign HEX5 = 7'b1111111;   
	
	// Logic to check if SW[3]..SW[0] match your bottom digit, 6
	logic digit_bottom, sw3_not, sw0_not;
	not n1 (sw0_not, SW[0]);
	not n2 (sw3_not, SW[3]);
	and and1 (digit_bottom, sw0_not, sw3_not, SW[1], SW[2]);
	
	
	// and SW[7]..SW[4] match the next. 2
	logic digit_next, sw5_not;
	not n3 (sw5_not, SW[5]);
	nor nor1 (digit_next, SW[7], SW[6], sw5_not, SW[4]);
	
	// Result should drive LEDR[0].  Will check if the input reads 26.
	and and2 (LEDR[0], digit_bottom, digit_next);
	
endmodule  

module DE1_SoC_testbench(); 
	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	logic  [9:0] LEDR;    
	logic  [3:0] KEY;  
	logic  [9:0] SW;   
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);  
	
	// Try all combinations of inputs. 
	integer i;  
	initial begin  
		SW[9] = 1'b0;  
		SW[8] = 1'b0;  
		for(i = 0; i <256; i++) begin  
			SW[7:0] = i; #10;  
		end  
	end  
endmodule