module decoder3_8(out, in, enable);
	
	output logic [7:0] out;
	input logic [2:0] in;
	logic in2_bar;
	
	not #50 n0(in2_bar, in[2]);
	decoder2_4 dec0(out[3:0], in[1:0], in2_bar);
	decoder2_4 dec1(out[7:4], in[1:0], in[2]);
	
endmodule
