// Lab 8: Elevator
// Michael Humphrey 3/6/2018 SID:1536326
module buttons_controller (selection, curr_floor, switches_6, clk, reset);
	output logic [5:0] selection;
	
	input logic [5:0] switches_6;
	input logic clk, reset;
	input logic [2:0] curr_floor;
	
	logic [5:0] ps, ns;
	integer i;
	
	always_comb begin
		for (i = 3'b0; i < 3'b110; i++) begin
			// turn off selection for floor the elevator is on
			if (i[2:0] == curr_floor) begin
				ns[i[2:0]] = 1'b0;
			end
			// uses switch at 'i' to select floors
			else if (switches_6[i[2:0]]) ns[i[2:0]] = 1'b1;
			
			// keep old values
			else ns[i[2:0]] = ps[i[2:0]];
			
		end
	end
	
	always_ff @(posedge clk) begin
		// turns off all selections on reset
		if (reset) begin
			ps <= 6'b0;
			selection <= 6'b0;
		end
		else begin
			ps <= ns;
			selection <= ns;
		end
		
	end
	
endmodule


module buttons_controller_testbench();
	logic clk, reset;
	logic [2:0] curr_floor;
	logic [5:0] selection;
	logic [5:0] switches_6;
	
	buttons_controller dut (.selection, .curr_floor, .switches_6, .clk, .reset);
	
	parameter CLOCK_PERIOD=100;  
	initial begin  
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  
	end  
	
	initial begin
		reset <= 1; switches_6 = 6'b0; curr_floor = 3'b0;	@(posedge clk);
		reset <= 0; 											@(posedge clk);
		switches_6 = 6'b100101; @(posedge clk);
		curr_floor = 3'b110; @(posedge clk);
		curr_floor = 3'b011; @(posedge clk);
		#1000;

		
		$stop;
		
	end
	
endmodule
