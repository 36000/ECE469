
module decoder2_4(out, in, enable);
	
	output logic [3:0] out;
	input logic [1:0] in;
	input logic enable;
	logic in0_bar, in1_bar;
	
	not #50 not0(in0_bar, in[0]);
	not #50 not1(in1_bar, in[1]);
	
	and_3 and0(out[0], in0_bar, in1_bar, enable);
	and_3 and1(out[1], in1_bar, in[0], enable);
	and_3 and2(out[2], in[1], in0_bar, enable);
	and_3 and3(out[3], in[1], in[0], enable);

endmodule
