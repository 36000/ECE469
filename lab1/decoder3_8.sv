module decoder3_8(out, in, enable);
	
	output logic [7:0] out;
	input logic [2:0] in;
	input logic enable;
	logic in2_bar;
	logic [7:0] unenabled_out;
	
	not #50 n0(in2_bar, in[2]);
	decoder2_4 dec0(unenabled_out[3:0], in[1:0], in2_bar);
	decoder2_4 dec1(unenabled_out[7:4], in[1:0], in[2]);
	
	genvar i;
	generate
		for (i=0; i<=7; i++) begin : and_gates
			and #50 enabled_out_gate (out[i], unenabled_out[i], enable);
		end
	endgenerate
	
endmodule


module decoder3_8_testbench();
		logic [7:0] out;
		logic [2:0] in;
		logic enable;
		
		decoder3_8 dut (.out, .in, .enable);
		integer i;
		
		initial begin
			for (i = 0; i < 5'b10000; i++) begin
				in = i[2:0];
				enable = i[3];
				#1000;
			end
			$stop;
			
		end
endmodule