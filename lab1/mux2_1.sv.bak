//  2 to 1 mux
module mux2_1(out, in0, in1, select);

	input logic in0, in1, select;
	output logic out;
	logic s_bar, w1, w2;

	not #50 not1(s_bar, select);
	
	
	and #50 and1(w1, s_bar, in0);
	and #50 and2(w2, select, in1);

	or #50 or1(out, w1, w2);

endmodule


module mux2_1_testbench();
		logic in0, in1, select;
		logic out;
		
		mux2_1 dut (.out, .in0, .in1, .select);
		
		initial begin
				select=0; in0=0; in1=0; #1000;
				select=0; in0=0; in1=1; #1000;
				select=0; in0=1; in1=0; #1000;
				select=0; in0=1; in1=1; #1000;
				select=1; in0=0; in1=0; #1000;
				select=1; in0=0; in1=1; #1000;
				select=1; in0=1; in1=0; #1000;
				select=1; in0=1; in1=1; #1000;
		end
endmodule
