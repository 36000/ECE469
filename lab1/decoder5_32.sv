module decoder5_32 (out, in, enable);
	
	output logic [31:0] out;
	input logic [4:0] in;
	logic enable;
	logic [3:0] decoder3_8_enables;
	
	decoder2_4 in_top_bits (decoder3_8_enables, in[4:3], enable);
	
	generate
		for (logic [1:0] i=0; i<=3; i++) begin : decoder3_8s
			decoder3_8 dec (out[(i+1)*8-1 : i*8], in[2:0], decoder3_8_enables[i]);
		end
	endgenerate
	
endmodule
