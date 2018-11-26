`timescale 1ns/10ps

module decoder5_32 (out, in, enable);
	
	output logic [31:0] out;
	input logic [4:0] in;
	input logic enable;
	logic [3:0] decoder3_8_enables;
	
	decoder2_4 in_top_bits (decoder3_8_enables, in[4:3], enable);
	
	genvar i;
	generate
		for (i=0; i<=3; i++) begin : decoder3_8s
			decoder3_8 dec (out[(i+1)*8-1 : i*8], in[2:0], decoder3_8_enables[i]);
		end
	endgenerate
	
endmodule


module decoder5_32_testbench();
		logic [31:0] out;
		logic [4:0] in;
		logic enable;
		
		decoder5_32 dut (.out, .in, .enable);
		integer i;
		
		initial begin
			for (i = 0; i < 7'b1000000; i++) begin
				in = i[4:0];
				enable = i[5];
				#1000;
			end
			$stop;
			
		end
endmodule