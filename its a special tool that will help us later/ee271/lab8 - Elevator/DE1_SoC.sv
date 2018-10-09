// Lab 8: Elevator
// Michael Humphrey 3/6/2018 SID:1536326
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);   
	input  logic         CLOCK_50; // 50MHz clock.   
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;      
	input  logic  [3:0]  KEY; // True when not pressed, False when pressed   
	input  logic  [9:0]  SW;    
	
	assign HEX2 = ~7'b0000000; // blank
	assign HEX3 = ~7'b0000000; // blank
	assign LEDR[6] = 1'b0;
	// Generate clk off of CLOCK_50, whichClock picks rate. 
	logic [31:0] clk;  
	parameter whichClock = 22;  
	clock_divider cdiv (CLOCK_50, clk, ~KEY[3]);  
	
	// Buffer the reset signal
	logic temp_reset, reset;
	myDFF dff1 (temp_reset, SW[9], clk[whichClock], 1'b0); // want the inputs to be buffered by two dffs
	myDFF dff2 (reset, temp_reset, clk[whichClock], 1'b0);
	
	logic [5:0] temp_switches, buff_switches;
	myDFF_6b dff3 (temp_switches, SW[5:0], clk[whichClock], reset);
	myDFF_6b dff4 (buff_switches, temp_switches, clk[whichClock], reset);
	
	logic close_temp, close_temp2, close_doors;
	myDFF dff5 (close_temp, ~KEY[0], clk[whichClock], reset); // want the inputs to be buffered by two dffs
	myDFF dff6 (close_temp2, close_temp, clk[whichClock], reset);
	input_blink blink1 (close_doors, close_temp2, clk[whichClock], reset);
	
	logic [5:0] selection;
	logic [2:0] curr_floor;
	logic [1:0] doors_open;
	logic direction;
	buttons_controller elevatorButtons (.selection, .curr_floor, .switches_6(buff_switches), .clk(clk[whichClock]), .reset);
	floor_tracker elevatorController (.curr_floor, .doors_open, .direction, .close_doors, .selection, .reset, .clk(clk[whichClock]));
	
	assign LEDR[5:0] = selection;
	assign LEDR[8:7] = doors_open;
	assign LEDR[9] = clk[whichClock];
	
	always_comb begin
		case(direction)
			1'b1: begin
				HEX5 = ~7'b0111110; // U
				HEX4 = ~7'b1110011; // P
			end
			1'b0: begin
				HEX5 = ~7'b1011110; // d
				HEX4 = ~7'b1010100; // n
			end
		endcase
		
		case(curr_floor)
			3'b000: begin
				HEX1 = ~7'b0000110; // 1
				HEX0 = ~7'b0000000; // 
			end
			3'b001: begin
				HEX1 = ~7'b1011011; // 2
				HEX0 = ~7'b0000000; // 
			end
			3'b010: begin
				HEX1 = ~7'b1011011; // 2
				HEX0 = ~7'b1000000; // -
			end
			3'b011: begin
				HEX1 = ~7'b1001111; // 3
				HEX0 = ~7'b0000000; // 
			end
			3'b100: begin
				HEX1 = ~7'b1001111; // 3
				HEX0 = ~7'b1000000; // -
			end
			3'b101: begin
				HEX1 = ~7'b1100110; // 4 
				HEX0 = ~7'b0000000; // 
			end
			default: begin
				HEX1 = ~7'b0000000; // 
				HEX0 = ~7'b0000000; // 
			end
		endcase
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
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
	// Testbench is only useful when using dividedclocks[0]
	initial begin  
	KEY[3]<=0; 								#400;
	KEY[3]<=1; 	SW[9:0] = 10'b0;		#400;
	KEY[0]<=1;								#400;
	SW[9]<=1; 								#1600;
	SW[9]<=0;								#1600;
	SW[5]<=1;#400;SW[5]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[0]<=1;#400;SW[0]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[4]<=1;#400;SW[4]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[1]<=1;#400;SW[1]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[3]<=1;#400;SW[3]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[2]<=1;#400;SW[2]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	SW[0]<=1;#400;SW[0]<=0; KEY[0]<=0;#400;KEY[0]<=1;	#1600;
	
	
	$stop; // End the simulation.  
	end 
	
endmodule