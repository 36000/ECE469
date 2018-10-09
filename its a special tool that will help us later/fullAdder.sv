
module fullAdder (A,B, cin, sum, cout);

	input logic A,B, cin;
	output logic sum, cout;
	
	assign sum = A ^ B ^ cin;
	assign cout = A&B | cin & (A^B);

endmodule

module fullAdder_testbench();

		logic A,B, cin, sum, cout;
		
		fullAdder dut (A,B, cin, sum, cout);
		
		initial begin
		
			A=0;B=0;cin=0; #10;
					  cin=1; #10;
				 B=1;cin=0; #10;
					  cin=1; #10;
			A=1;B=0;cin=0; #10;
					  cin=1; #10;
				 B=1;cin=0; #10;
					  cin=1; #10;
				  
		$stop;
		
		end //initial
				  
endmodule









