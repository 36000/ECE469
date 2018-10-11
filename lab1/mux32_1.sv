//  32 to 1 mux
module mux32_1(out, in, select);

	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	logic [9:0] wires;

	genvar i;
	generate
		for(i=0; i<8; i++) begin : lvl1s
			mux4_1 lvl1 (wires[i], in[i*4+3:i*4], select[1:0]);
		end
	endgenerate
	
	mux4_1 mux0 (wires[8], wires[3:0], select[3:2]);
	mux4_1 mux1 (wires[9], wires[7:4], select[3:2]);
	
	mux2_1 mux2 (out, wires[8], wires[9], select[4]);

endmodule

module mux32_1_testbench();

	logic [31:0] in;
	logic [4:0] select;
	logic out, clk;
	
	parameter ClockDelay = 5000;
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	mux32_1 dut (.out, .in, .select);

	initial begin
		@(negedge clk);
		in <=32'b01110100100101001100111001011001; select<=5'b00000; @(negedge clk);
		in <=32'b01110100100101001100111001011001; select<=5'b01010; @(negedge clk);
		in <=32'b01110100100101001100111001011001; select<=5'b11110; @(negedge clk);
		in <=32'b10100100101101010110001011110101; select<=5'b00000; @(negedge clk);
		in <=32'b10100100101101010110001011110101; select<=5'b01010; @(negedge clk);
		in <=32'b10100100101101010110001011110101; select<=5'b11110; @(negedge clk);
		$stop;
	end

endmodule
