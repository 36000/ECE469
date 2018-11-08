`timescale 1ns/10ps

module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);

output logic [63:0] ReadData1, ReadData2;
input logic [63:0] WriteData;
input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
input logic RegWrite, clk;

logic [31:0] reg_write_enables;
logic [31:0] [63:0] reg_outputs;
logic [63:0] [31:0] reg_outputs_rotated;

//connect decoder for writing
decoder5_32 decoder (reg_write_enables, WriteRegister, RegWrite);

//connect 32 registers
genvar i;
generate
	for(i=0; i<31; i++) begin : regs
		register_64 reggie (reg_outputs[i], WriteData, reg_write_enables[i], 1'b0, clk);
	end
endgenerate
//register 31 always outputs 0
register_64 reg31 (reg_outputs[31], 64'b0, 1'b1, 1'b0, clk);


//rotate register outputs to fit multiplexors
genvar j, k;
generate
	for(j=0;j<32;j++) begin : reg_index
	 for(k=0;k<64;k++) begin : byte_index
	  always_comb reg_outputs_rotated[k][j] = reg_outputs[j][k];
	 end
	end
endgenerate


//connect multiplexors for reading
mux64x32_64 read1 (ReadData1, reg_outputs_rotated, ReadRegister1);
mux64x32_64 read2 (ReadData2, reg_outputs_rotated, ReadRegister2);


endmodule
