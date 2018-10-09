// Lab 6: Tug of War
// Michael Humphrey 2/13/2018 SID:1536326
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);   
	input  logic         CLOCK_50; // 50MHz clock.   
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;      
	input  logic  [3:0]  KEY; // True when not pressed, False when pressed   
	input  logic  [9:0]  SW;    
	assign HEX1 = ~7'b0000000; // blank
	assign HEX2 = ~7'b0000000; // blank
	assign HEX3 = ~7'b0000000; // blank
	assign HEX4 = ~7'b0000000; // blank
	assign HEX5 = ~7'b0000000; // blank
	assign LEDR[0] = 1'b0;
	// Generate clk off of CLOCK_50, whichClock picks rate. 
	logic [31:0] clk;  
	parameter whichClock = 0;  
	clock_divider cdiv (CLOCK_50, clk, SW[0]);  
	
	
	// Hook up FSM inputs and outputs.    
	// Buffer the input signals and ensure they can never both be true
	logic buffL, buffR;
	input_buffer inbuff (.outL(buffL), .outR(buffR), .inL(~KEY[3]), .inR(~KEY[0]), .clk(clk[whichClock]), .reset(SW[0]));
	// Ensure that both inputs are only true for once clock cycle if button is pressed
	logic inL, inR;
	input_blink inblinkL (.out(inL), .in(buffL), .clk(clk[whichClock]), .reset(SW[0]));
	input_blink inblinkR (.out(inR), .in(buffR), .clk(clk[whichClock]), .reset(SW[0]));
	// Generate the lights for the board
	play_light led9 (LEDR[9], inL, inR, 1'b0, LEDR[8], 1'b0, clk[whichClock], SW[0]);
	play_light led8 (LEDR[8], inL, inR, LEDR[9], LEDR[7], 1'b0, clk[whichClock], SW[0]);
	play_light led7 (LEDR[7], inL, inR, LEDR[8], LEDR[6], 1'b0, clk[whichClock], SW[0]);
	play_light led6 (LEDR[6], inL, inR, LEDR[7], LEDR[5], 1'b0, clk[whichClock], SW[0]);
	play_light led5 (LEDR[5], inL, inR, LEDR[6], LEDR[4], 1'b1, clk[whichClock], SW[0]);
	play_light led4 (LEDR[4], inL, inR, LEDR[5], LEDR[3], 1'b0, clk[whichClock], SW[0]);
	play_light led3 (LEDR[3], inL, inR, LEDR[4], LEDR[2], 1'b0, clk[whichClock], SW[0]);
	play_light led2 (LEDR[2], inL, inR, LEDR[3], LEDR[1], 1'b0, clk[whichClock], SW[0]);
	play_light led1 (LEDR[1], inL, inR, LEDR[2], 1'b0, 1'b0, clk[whichClock], SW[0]);
	logic winner1, winner2, win_on1, win_on2;
	play_light p1win (winner1, inL, inR, LEDR[1], 1'b0, 1'b0, clk[whichClock], SW[0]);
	play_light p2win (winner2, inL, inR, 1'b0, LEDR[9], 1'b0, clk[whichClock], SW[0]);
	
	always_comb begin
		if (winner1)
			HEX0 = ~7'b0000110; // 1 
		else if (winner2)
			HEX0 = ~7'b1011011; // 2 
		else
			HEX0 = ~7'b0000000; // blank
	end
	
endmodule   

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...   
module clock_divider (clock, divided_clocks, reset); 
	input  logic          clock, reset;   
	output logic  [31:0]  divided_clocks; 
	
	always_ff @(posedge clock) begin 
		if(reset) begin
			divided_clocks <= 0;
		end else begin
			divided_clocks <= divided_clocks + 1;
		end
	end

endmodule


module DE1_SoC_testbench();
	logic clk;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed   
	logic [9:0] SW;    
	
	DE1_SoC dut (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin  
	SW[0]<=1; KEY[0]<=1; KEY[3]<=1; 	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	SW[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk); 
	KEY[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=1;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=1;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=1;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=1;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	KEY[0]<=0;								@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
											
		$stop; // End the simulation.  
	end 
	
endmodule