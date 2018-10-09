// Lab 7: CyberWar
// Michael Humphrey 2/20/2018 SID:1536326
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);   
	input  logic         CLOCK_50; // 50MHz clock.   
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;      
	input  logic  [3:0]  KEY; // True when not pressed, False when pressed   
	input  logic  [9:0]  SW;    
	
	assign HEX2 = ~7'b0000000; // blank
	assign HEX3 = ~7'b0000000; // blank
	assign HEX4 = ~7'b0000000; // blank
	assign HEX5 = ~7'b0000000; // blank
	assign LEDR[0] = 1'b0;
	// Generate clk off of CLOCK_50, whichClock picks rate. 
	logic [31:0] clk;  
	parameter whichClock = 0;  
	clock_divider cdiv (CLOCK_50, clk, ~KEY[1]);  
	
	   
	// Buffer the reset signal
	logic temp_reset, reset, field_reset;
	myDFF dff1 (temp_reset, SW[9], clk[whichClock], 1'b0); // want the inputs to be buffered by two dffs
	myDFF dff2 (reset, temp_reset, clk[whichClock], 1'b0);
	
	logic [9:0] inCOM_10bit;
	logic inCOM;
	LFSR_10bit computer_player (inCOM_10bit, reset, clk[whichClock]);
	comparator_10bit computer_player_input ({1'b0, SW[8:0]}, inCOM_10bit, inCOM);
	
	// Buffer the input signals and ensure they can never both be true
	logic buffL, buffR;
	input_buffer inbuff (.outL(buffL), .outR(buffR), .inL(inCOM), .inR(~KEY[0]), .clk(clk[whichClock]), .reset);

	// Ensure that both inputs are only true for once clock cycle if button is pressed
	logic inL, inR;
	input_blink inblinkL (.out(inL), .in(buffL), .clk(clk[whichClock]), .reset);
	input_blink inblinkR (.out(inR), .in(buffR), .clk(clk[whichClock]), .reset);

	// Generate the lights for the board
	play_light led9 (LEDR[9], inL, inR, 1'b0, LEDR[8], 1'b0, clk[whichClock], field_reset);
	play_light led8 (LEDR[8], inL, inR, LEDR[9], LEDR[7], 1'b0, clk[whichClock], field_reset);
	play_light led7 (LEDR[7], inL, inR, LEDR[8], LEDR[6], 1'b0, clk[whichClock], field_reset);
	play_light led6 (LEDR[6], inL, inR, LEDR[7], LEDR[5], 1'b0, clk[whichClock], field_reset);
	play_light led5 (LEDR[5], inL, inR, LEDR[6], LEDR[4], 1'b1, clk[whichClock], field_reset);
	play_light led4 (LEDR[4], inL, inR, LEDR[5], LEDR[3], 1'b0, clk[whichClock], field_reset);
	play_light led3 (LEDR[3], inL, inR, LEDR[4], LEDR[2], 1'b0, clk[whichClock], field_reset);
	play_light led2 (LEDR[2], inL, inR, LEDR[3], LEDR[1], 1'b0, clk[whichClock], field_reset);
	play_light led1 (LEDR[1], inL, inR, LEDR[2], 1'b0, 1'b0, clk[whichClock], field_reset);
	
	logic win1, win2;
	play_light p1win (win1, inL, inR, LEDR[1], 1'b0, 1'b0, clk[whichClock], field_reset);
	play_light p2win (win2, inL, inR, 1'b0, LEDR[9], 1'b0, clk[whichClock], field_reset);	
	
	logic win1b, win2b;
	input_blink blink_win1 (.out(win1b), .in(win1), .clk(clk[whichClock]), .reset);
	input_blink blink_win2 (.out(win2b), .in(win2), .clk(clk[whichClock]), .reset);
	score_counter p1count (win1b, clk[whichClock], reset, HEX0);
	score_counter p2count (win2b, clk[whichClock], reset, HEX1);
	
	// Reset the field if either player wins or the reset signal is activated
	assign field_reset = (win1b || win2b || reset);
	// assign field reset = (l9&L&~R || l1&R&~L || reset);
//	input_blink blink_f_reset (.out(field_reset), .in(win1b || win2b), .clk(clk[whichClock]), .reset);


//	always_comb begin
//		if (win1)
//			HEX0 = ~7'b0000110; // 1 
//		else if (win2)
//			HEX0 = ~7'b1011011; // 2 
//		else
//			HEX0 = ~7'b0000000; // blank
//	end
//	
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
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	// Testbench is only useful when using dividedclocks[0]
	initial begin  
	KEY[1]<=0; 								#1500; @(posedge clk);
	KEY[1]<=1; 	SW[8:0] = 10'b0;		#1500; @(posedge clk);
	SW[9]<=0; KEY[0]<=1; KEY[3]<=1; 	#1500; @(posedge clk);
	SW[9]<=1; 								#1500; @(posedge clk);
	SW[9]<=0;								#1500; @(posedge clk);
	KEY[0]<=0; SW[8:0] = 10'b0000011111; #1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);

	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);

	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	KEY[0]<=0;								#1500; @(posedge clk);
	KEY[0]<=1;								#1500; @(posedge clk);
	
//	SW[9]<=1; KEY[0]<=1;					#1500; @(posedge clk);
//	SW[9]<=0;								#1500; @(posedge clk);
		$stop; // End the simulation.  
	end 
	
endmodule