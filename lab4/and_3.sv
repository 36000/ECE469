`timescale 1ns/10ps

module and_3(out, a, b, c);

	output logic out;
	input logic a,b,c;
	logic w1;
	
	and #50 and0(w1, a, b);
	and #50 and1(out, w1, c);

endmodule

module and_3_testbench();
		logic a, b, c;
		logic out;
		
		and_3 dut (.out, .a, .b, .c);
		integer i;
		
		initial begin
			for (i = 0; i < 8; i++) begin
				a = i[0];
				b = i[1];
				c = i[2];
				#1000;
			end
			$stop;
			
		end
endmodule
