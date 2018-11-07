`timescale 1ns/10ps

//  shift left by 2
module LSL_2(out, in);

	input logic [63:0] in
	output logic [63:0] out;
	
	assign out[1:0] = 2'b00;
	assign out[63:2] = in[61:0];
	
endmodule