//  32 to 1 mux
module mux32_1(out, in, select);

	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	logic [9:0] wires;

	generate
		for(i=0; i<8; i++) begin : lvl1s
			mux4_1 lvl1 (wires[i], in[i*4], in[i*4+1], in[i*4+2], in[i*4+3], select[1], select[0]);
		end
	endgenerate
	
	mux4_1(wires[8], wires[0], wires[1], wires[2], wires[3], select[3], select[2]);
	mux4_1(wires[9], wires[4], wires[5], wires[6], wires[7], select[3], select[2]);
	
	mux2_1(out, wires[8], wires[9], select[4]);

endmodule
