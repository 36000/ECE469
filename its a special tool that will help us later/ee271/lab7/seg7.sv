// Testing the 7 segment displays on the DE1 board
// Michael Humphrey 1/30/2018 SID:1536326

module seg7 (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);  
	output logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;  
	output logic  [9:0]    LEDR;   
	input  logic  [3:0]    KEY;    
	input  logic  [9:0]   SW;   
		always_comb begin 
		
			case (SW[3:0]) 
				//          Light: 6543210 
				4'b0000: HEX0 = ~7'b0111111; // 0 
				4'b0001: HEX0 = ~7'b0000110; // 1 
				4'b0010: HEX0 = ~7'b1011011; // 2 
				4'b0011: HEX0 = ~7'b1001111; // 3 
				4'b0100: HEX0 = ~7'b1100110; // 4 
				4'b0101: HEX0 = ~7'b1101101; // 5 
				4'b0110: HEX0 = ~7'b1111101; // 6 
				4'b0111: HEX0 = ~7'b0000111; // 7 
				4'b1000: HEX0 = ~7'b1111111; // 8 
				4'b1001: HEX0 = ~7'b1101111; // 9 
				default: HEX0 = ~7'bX; 
			endcase 
			
			case (SW[7:4])
				//          Light: 6543210 
				4'b0000: HEX1 = ~7'b0111111; // 0 
				4'b0001: HEX1 = ~7'b0000110; // 1 
				4'b0010: HEX1 = ~7'b1011011; // 2 
				4'b0011: HEX1 = ~7'b1001111; // 3 
				4'b0100: HEX1 = ~7'b1100110; // 4 
				4'b0101: HEX1 = ~7'b1101101; // 5 
				4'b0110: HEX1 = ~7'b1111101; // 6 
				4'b0111: HEX1 = ~7'b0000111; // 7 
				4'b1000: HEX1 = ~7'b1111111; // 8 
				4'b1001: HEX1 = ~7'b1101111; // 9 
				default: HEX1 = ~7'bX; 
			endcase
			
		end 
endmodule  

module seg7_testbench(); 
	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	logic  [9:0] LEDR;    
	logic  [3:0] KEY;  
	logic  [9:0] SW;   
	
	seg7 dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);  
	
	// Try all combinations of inputs. 
	integer i;  
	initial begin  
		for(i = 0; i<15; i++) begin
			SW[3:0] = i; 
			SW[7:4] = i; #10;
		end
	end  
endmodule