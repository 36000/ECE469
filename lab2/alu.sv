`timescale 1ns/10ps

//  ALU
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);

	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	
	logic zeroBar;
	logic subtract;
	logic [63:0] carries_out;

	// connect the 1 bit ALUs
	genvar i;
	ALU_1 firstALU (.A(A[0]), .B(B[0]), .C_in(subtract), .sub(subtract), .cntrl, .C_out(carries_out[0]), .S(result[0]));
	generate
		for (i = 1; i < 64; i++) begin : ALUs
			ALU_1 ALU1bit (.A(A[i]), .B(B[i]), .C_in(carries_out[i - 1]), .sub(subtract), .cntrl, .C_out(carries_out[i]), .S(result[i]));
		end
	endgenerate
	
	// establish 'subtract' signal from control signal
	and #50 subSignal (subtract, cntrl[1], cntrl[0]);
	
	// establish 'carry_out' output signal
	assign carry_out = carries_out[63];
	// establish 'negative' output signal
	assign negative = result[63];	
	// establish 'overflow' output signal
	xor #50 ovrflwSignal (overflow, carries_out[63], carries_out[62]);
	
	// establish 'zero' output signal
	or_64 zeroSignalBar (result, zeroBar);
	not #50 zeroSignal (zero, zeroBar);
	
endmodule



module alu_testbench();
	
	logic [63:0] A, B;
	logic [2:0] cntrl;
	logic [63:0] result;
	logic negative, zero, overflow, carry_out;
	// r=B, add, subtract, AND, OR, XOR
	
	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);
	
	initial begin
		A = 64'b0110110100110110110101110100110001101010111110100000110110110100;
		B = 64'b0;
		// test the pass B and 'zero' signal
		cntrl = 3'b000; #5000;
		// test pass B and 'negative' signal
		B = 64'b1111000101010010101010101001000110110101011101010101101101010101; #5000;
		// test 'overflow' signal
		B = 64'b0111000101010010101010101001000110110101011101010101101101010101;
		cntrl = 3'b010; #5000;
		// test add
		B = 64'b0001000101010010101010101001000110110101011101010101101101010101; #5000;
		// test subtract
		cntrl = 3'b011; #5000;
		// test and
		cntrl = 3'b100; #5000;
		// test or
		cntrl = 3'b101; #5000;
		// test xor
		cntrl = 3'b110; #5000;
	end
	
	
endmodule
