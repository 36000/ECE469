
// lab 3 requires SE 9, 12, 19, 26 -> 64 bit
module SE_64 #(parameter input_size = 26;) (out, in);
	input logic [input_size-1:0] in;
	output logic [63:0] out;
	
	assign out = {(64-input_size){in[input_size-1}, in};
	
endmodule

