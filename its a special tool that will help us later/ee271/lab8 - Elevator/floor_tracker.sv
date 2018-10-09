// Lab 8: Elevator
// Michael Humphrey 3/6/2018 SID:1536326
module floor_tracker (curr_floor, doors_open, direction, close_doors, selection, reset, clk);
	output logic [2:0] curr_floor;
	output logic [1:0] doors_open;
	output logic direction;
	
	input logic close_doors, reset, clk;
	input logic [5:0] selection;
	
	parameter [2:0] F1 = 3'b000, F2 = 3'b001, F2m = 3'b010, F3 = 3'b011, F3m = 3'b100, F4 = 3'b101;
	parameter [1:0] neither = 2'b00, east = 2'b01, west = 2'b10, both = 2'b11;
	// direction logic
	// direction: 1 = up, 0 = down
	logic dir_ns;
	logic [1:0] doors_ns;
	logic [2:0] floor_ns;
	
	always_comb begin
		// If the doors are open
		if (doors_open != neither) begin
			floor_ns = curr_floor;
			dir_ns = direction;
			if (close_doors) doors_ns = neither;
			else doors_ns = doors_open;
		end
		// Doors are closed and no floors selected
		else if (selection == 6'b0) begin
			floor_ns = curr_floor;
			dir_ns = direction;
			doors_ns = neither;
		end
		// Now the doors are closed and some floor is selected
		else begin
			case(curr_floor)
			
				// When on floor 1 always go up if another floor is selected
				//		((selection - 6'b000001) > 0)???
				F1: begin
					if (direction) begin
						floor_ns = F2;
						dir_ns = direction;
						if (selection[1]) doors_ns = both;
						else doors_ns = neither;
					end
					// Wrong direction, flip dir_ns
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
				end
				
				 // if higher floors selected and direction is up
				F2: begin
					if ((selection > 6'b000010) & direction) begin
						floor_ns = F2m;
						dir_ns = direction;
						if (selection[2]) doors_ns = west;
						else doors_ns = neither;
					end
					// Lower floor must be selected
					else if (selection[0] & ~direction) begin
						dir_ns = direction;
						floor_ns = F1;
						doors_ns = both;
					end
					// Wrong direction, flip dir_ns
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
				end
				
				F2m: begin
					if ((selection > 6'b000100) & direction) begin
						floor_ns = F3;
						dir_ns = direction;
						if (selection[3]) doors_ns = east;
						else doors_ns = neither;
					end
					// Going down
					else if ((selection[1:0] > 2'b0) & ~direction) begin
						floor_ns = F2;
						dir_ns = direction;
						if (selection[1]) doors_ns = both;
						else doors_ns = neither;
					end
					// wrong direction
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
				end
				
				F3: begin
					if ((selection > 6'b001000) & direction) begin
						floor_ns = F3m;
						dir_ns = direction;
						if (selection[4]) doors_ns = west;
						else doors_ns = neither;
					end
					// Going down
					else if ((selection[2:0] > 3'b0) & ~direction) begin
						floor_ns = F2m;
						dir_ns = direction;
						if (selection[2]) doors_ns = west;
						else doors_ns = neither;
					end
					// wrong direction
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
				end
				
				F3m: begin
					if (selection[5] & direction) begin
						floor_ns = F4;
						dir_ns = direction;
						doors_ns = both;
					end
					// Going down
					else if ((selection[3:0] > 3'b0) & ~direction) begin
						floor_ns = F3;
						dir_ns = direction;
						if (selection[3]) doors_ns = east;
						else doors_ns = neither;
					end
					// wrong direction
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
				end
				
				F4: begin
					if ((selection[4:0] > 3'b0) & ~direction) begin
						floor_ns = F3m;
						dir_ns = direction;
						if (selection[4]) doors_ns = west;
						else doors_ns = neither;
					end
					// wrong direction
					else begin
						floor_ns = curr_floor;
						dir_ns = ~direction;
						doors_ns = neither;
					end
					
				end
				
				default: begin 
					floor_ns = F1;
					dir_ns = direction;
					doors_ns = 2'b00;
				end
			endcase
		end
		
	end
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			curr_floor <= F1;
			direction <= 1'b1;
			doors_open <= both;
		end
		else begin
			curr_floor <= floor_ns;
			direction <= dir_ns;
			doors_open <= doors_ns;
		end
	end
	
endmodule

// F4:  both
// F3m: west
// F3:  east
// F2m: west
// F2:  both
// F1:  both


module floor_tracker_testbench();
	logic clk, reset, close_doors, direction;
	logic [1:0] doors_open;
	logic [2:0] curr_floor;
	logic [5:0] selection;
	
	floor_tracker dut (.curr_floor, .doors_open, .direction, .close_doors, .selection, .reset, .clk);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	initial begin
		reset <= 1; selection = 6'b0;	close_doors = 1'b0;	@(posedge clk);
		reset <= 0; 													@(posedge clk);
		#1000;
		selection <= 6'b100000;	@(posedge clk);
										@(posedge clk);
		close_doors <= 1;	@(posedge clk);
		close_doors <= 0;	#600;
		selection <= 6'b0;	@(posedge clk);
		close_doors <= 1;	@(posedge clk);
		close_doors <= 0;	@(posedge clk);
		selection <= 6'b001010; @(posedge clk);
		#1000;
		
		$stop;
		
	end
	
endmodule
