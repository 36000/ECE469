`timescale 1ns/10ps

//  input flags, output conditional signals
module (outflags, CBZ, BLT, negative, zero, overflow, carry_out, reset, enable);
    input logic negative, zero, overflow, carry_out, enable;
	output logic CBZ, BLT;
	output logic [3:0] outflags;
	
	D_FF_e dff0(outflags[0], negative, enable, reset, clk);
	D_FF_e dff1(outflags[1], zero, enable, reset, clk);
	D_FF_e dff2(outflags[2], overflow, enable, reset, clk);
	D_FF_e dff3(outflags[3], carry_out, enable, reset, clk);
	
	xor #50 blt(BLT, outflags[0], outflags[2]);
	assign CBZ = outflags[1];
endmodule