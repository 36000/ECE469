`timescale 1ns/10ps

//  input flags, output conditional signals
module flagfile(outflags, CBZ, BLT, negative, zero, overflow, carry_out, reset, enable);
    input logic negative, zero, overflow, carry_out, enable;
	output logic CBZ, BLT;
	output logic [3:0] outflags;
	
	register_1 reg0(outflags[0], negative, enable, reset, clk);
	register_1 reg1(outflags[1], zero, enable, reset, clk);
	register_1 reg2(outflags[2], overflow, enable, reset, clk);
	register_1 reg3(outflags[3], carry_out, enable, reset, clk);
	
	xor #50 blt(BLT, outflags[0], outflags[2]);
	assign CBZ = outflags[1];
endmodule