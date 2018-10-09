module comparator_10bit (A,B,A_gt_B);
	input logic [9:0] A,B;
	output logic A_gt_B;
	
	assign A_gt_B = (A > B);
	
	
endmodule

module comparator_10bit_testbench();
	logic out;
	logic [9:0] A, B;
	assign A = 10'b1001001100;
	assign B = 10'b0010001010;
	comparator_10bit dut (A,B,out);
	
	
endmodule
