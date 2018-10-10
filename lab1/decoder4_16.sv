module decoder4_16(out, in, enable);
	
	output logic [15:0] out;
	input logic [3:0] in;
	logic in3_bar;
	
	not #50 n0(in3_bar, in[3]);
	decoder2_4 dec0(out[3:0], in[1:0], in2_bar);
	decoder2_4 dec1(out[7:4], in[1:0], in[2]);
	
endmodule
