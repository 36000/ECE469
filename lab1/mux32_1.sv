//  32 to 1 mux
module mux32_1(out, in, select);

	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	logic [9:0] wires;

	generate
		for(i=0; i<4; i++) begin : lvl1
			mux4_1 lvl1 ();
		end
	endgenerate 

endmodule
