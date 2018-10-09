// Multi-level logic on the FPGA
// Michael Humphrey 1/23/2018 SID:1536326
 
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
	
	// U,P,C go to SW[9],SW[8],SW[7] respectively. Mark goes to SW[0].
	// Discount light goes to LEDR[1].
	logic uc;
	and a1 (uc, SW[9], SW[7]);
	or o1 (LEDR[1], uc, SW[8]);
	
	// Stolen light goes to LEDR[0].
	logic notc, temp;
	not n1 (notc, SW[7]);
	nor no1 (temp, notc, SW[9]);
	nor no2 (LEDR[0], temp, SW[0], SW[8]);
	
	
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
		SW[0] = 1'b0;
		for(i = 0; i <8; i++) begin  
			SW[9:7] = i; #10;  
		end  
		SW[0] = 1'b1;
		for(i = 0; i <8; i++) begin  
			SW[9:7] = i; #10;  
		end  
	end  
endmodule