
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

module decoder2_4_testbench();
		logic [3:0] out;
		logic [1:0] in;
		logic enable;
		
		decoder2_4 dut (.out, .in, .enable);
		
		initial begin
				enable=0; in=2'b00; #1000;
				enable=0; in=2'b01; #1000;
				enable=0; in=2'b10; #1000;
				enable=0; in=2'b11; #1000;
				enable=1; in=2'b00; #1000;
				enable=1; in=2'b01; #1000;
				enable=1; in=2'b10; #1000;
				enable=1; in=2'b11; #1000;
		end
endmodule