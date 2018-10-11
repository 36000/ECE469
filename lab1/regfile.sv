module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, clk);

output logic [63:0] ReadData1, ReadData2;
input logic [63:0] WriteData;
input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
input logic RegWrite, clk;

logic [31:0] reg_write_enables;
logic [31:0] [63:0] reg_outputs;
logic [63:0] [31:0] reg_outputs_rotated;

//connect decoder for writing
decoder5_32(reg_write_enables, WriteRegister, RegWrite);

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
	always_comb begin
		for(j=0;j<32;
		foreach(reg_outputs[regi, byti]) reg_outputs_rotated[byti][regi] = reg_outputs[regi][byti];
	end
endgenerate


//connect multiplexors for reading
mux64x32_64 read1 (ReadData1, reg_outputs_rotated, ReadRegister1);
mux64x32_64 read2 (ReadData2, reg_outputs_rotated, ReadRegister2);


endmodule
