`timescale 1ns/10ps

// Singlecycle CPU 
module CPU_pipelined64(PC, reset, clk);
	input logic reset, clk;
	output logic [63:0] PC;
	
	logic [31:0] instr;
	logic [13:0] controlsigs;
	
	logic [63:0] execute_stage_result, f_Da, f_Db;
	logic PC_select;

	logic [4:0] Ab, Rd, Rn; logic [63:0] Da, Db, Dw; 
	logic RegWrite, EX_Br_Taken, EX_UncondBr;
	
	logic EX_enable, MEM_enable;
	logic [4:0] EX_id, MEM_id;
	
	logic [(32+14):0] IFstage_out;
	logic [(64+64+32+14):0] RFstage_out;
	logic [(64+64+1+32+14):0] EXstage_out;
	logic [(64+32+14):0] MEMstage_out;
	
	// Control Signals
	controlblock ControlBlock (controlsigs, instr[31:21]);
	
	// Instruction Fetch Stage
	IF instruction_fetch (.instr, .PC, .PC_select_b(1'b0), .PC_select_ub(PC_select), .EX_instr(RFstage_out[(32+14-1):14]), .BrTaken(EX_Br_Taken), .UncondBr(EX_UncondBr), .controlsigs, .reset, .clk);

	register_N #((32+14)) IFregister 
					(.out(IFstage_out), .in({instr, controlsigs}), .write(1'b1), .reset, .clk);
	
	
	// Register Fetch Stage
	RF register_fetch (.Ab, .Rn, .instr(IFstage_out[(32+14-1):14]), .controlsigs(IFstage_out[13:0]));
	/* multi-pipe drifting register file
	 Da, Db, Rn, Ab come from RF forwarding register 
	 Dw, Rd, RegWrite come from WB forwarding register 
	 */
	regfile register_file(Da, Db, 
				MEMstage_out[(64+32+14-1):(32+14)], 
				Rn, 
				Ab, Rd, RegWrite, ~clk);
	
	Register_Forward forwarding_control(.f_Da, .f_Db, .Da, .Db, .Aa(Rn), .Ab, .EX_Result(execute_stage_result), .EX_id, .EX_enable, .MEM_Result(Dw), .MEM_id, .MEM_enable);
	
	register_N #((64+64+32+14)) RFregister 
					(.out(RFstage_out), 
					.in({f_Da, f_Db, IFstage_out[(32+14-1):14], IFstage_out[13:0]}), 
					.write(1'b1), .reset, .clk);
	
	
	// Execute Stage
	EX execute (.logic_result(execute_stage_result), .PC_select,
				.Rd(EX_id), .F_enable(EX_enable), .EX_Br_Taken, .EX_UncondBr,
				.Da(RFstage_out[(64+64+32+14-1):(64+32+14)]), 
				.Db(RFstage_out[(64+32+14-1):(32+14)]), 
				.instr(RFstage_out[(32+14-1):14]), 
				.controlsigs(RFstage_out[13:0]), .clk, .reset);
	register_N #((64+64+1+32+14)) EXregister 
					(.out(EXstage_out), 
					.in({RFstage_out[(64+32+14-1):(32+14)], execute_stage_result, PC_select, RFstage_out[(32+14-1):14], RFstage_out[13:0]}), 
					.write(1'b1), .reset, .clk);
	
	// Data Memory Stage
	MEM data_memory (.Dw, .Rd(MEM_id), .F_enable(MEM_enable), 
				.logic_result(EXstage_out[(64+1+32+14-1):(1+32+14)]), 
				.Db(EXstage_out[(64+64+1+32+14-1):(64+1+32+14)]), 
				.instr(EXstage_out[(32+14-1):14]), 
				.controlsigs(EXstage_out[13:0]), .clk);
	register_N #((64+32+14)) MEMregister 
					(.out(MEMstage_out), 
					.in({Dw, EXstage_out[(32+14-1):14], EXstage_out[13:0]}), 
					.write(1'b1), .reset, .clk);
					
	// Writeback Stage
	WB writeback (.Rd, .RegWrite, .instr(MEMstage_out[(32+14-1):14]), .controlsigs(MEMstage_out[13:0]));
endmodule

module CPU_testbench();
	parameter ClockDelay = 20000;

	logic	      clk, reset;
	logic [63:0]  PCPrev, PC;
	
	CPU_pipelined64 dut(.PC, .reset, .clk);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		reset <=1; PCPrev = 64'b0; @(posedge clk);
		reset <=0; @(posedge clk); @(posedge clk); @(posedge clk);
		while (PCPrev != PC && PCPrev - 4 != PC) begin
			@(posedge clk); @(posedge clk); @(posedge clk); 
			@(posedge clk); @(posedge clk); @(posedge clk); 
			PCPrev <= PC;
			@(posedge clk);@(posedge clk); @(posedge clk); 
		end
		$stop;
	end
endmodule