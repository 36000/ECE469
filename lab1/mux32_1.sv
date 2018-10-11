//  32 to 1 mux
module mux32_1(out, in, select);

	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	logic [9:0] wires;

	genvar i;
	generate
		for(i=0; i<8; i++) begin : lvl1s
			mux4_1 lvl1 (wires[i], in[i*4+3:i*4], select[1:0]);
		end
	endgenerate
	
	mux4_1 mux0 (wires[8], wires[3:0], select[3:2]);
	mux4_1 mux1 (wires[9], wires[7:4], select[3:2]);
	
	mux2_1 mux2 (out, wires[8], wires[9], select[4]);

endmodule
