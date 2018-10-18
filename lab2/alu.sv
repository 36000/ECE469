//  ALU
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);

	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	
	logic subtract;
	logic [63:0] carries_out;

	// connect the 1 bit ALUs
	genvar i;
	ALU_1 firstALU (.A(A[0]), .B(B[0]), .C_in(subtract), .sub(subtract), .cntrl, .C_out(carries_out[0]), .S(result[0]));
	generate begin
		for (i = 1; i < 64; i++)
			ALU_1 ALU1bit (.A(A[i]), .B(B[i]), .C_in(carries_out[i - 1]), .sub(subtract), .cntrl, .C_out(carries_out[i]), .S(result[i]));
	end
	
	
	// establish 'subtract' signal from control signal
	and #50 subSignal (subtract, cntrl[1], cntrl[2]);
	
	// establish 'carry_out' output signal
	assign carry_out = carries_out[63];
	// establish 'negative' output signal
	assign negative = result[63];	
	// establish 'overflow' output signal
	xor #50 ovrflwSignal (overflow, carries_out[63], carries_out[62]);
	
	// establish 'zero' output signal
	/*
	logic [62:0] cascading_ORs;
	genvar j;
	generate begin
		for (j = 0; j < 63; j++)
			or #50 
	end
	*/
	
endmodule
