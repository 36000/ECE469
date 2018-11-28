`timescale 1ns/10ps

// Singlecycle CPU 
module CPU_pipelined64(PC, reset, clk);
	input logic reset, clk;
	output logic [63:0] PC;
	
	logic [31:0] instr;
	logic [13:0] controlsigs;
	
	logic [63:0] execute_stage_result;
	logic PC_select;

	logic [4:0] Ab, Rd, Rn; logic [63:0] Da, Db, Dw; 
	logic RegWrite;
	
	// Control Signals
	controlblock ControlBlock (controlsigs, instr[31:21]);
	
	// Instruction Fetch Stage
	IF instruction_fetch (.instr, .PC, .PC_select, .controlsigs, .reset, .clk);
	/* THIS IS NEW STUFF LOOK AT ME
	logic [(32+14):0] IFstage_out;
	register_N #(DATA_WIDTH=(32+14)) IFregister 
					(.out(IFstage_out), .in({instr, controlsigs}), .write(1'b1), .reset, .clk)
	*/
	
	// Register Fetch Stage
	RF register_fetch (.Ab, .Rn, .instr, .controlsigs);

	// multi-pipe drifting register file
	// Da, Db, Rn, Ab come from RF forwarding register 
	// Dw, Rd, RegWrite come from WB forwarding register 
	// SET clk TO ~clk AT SOME POINT FOR FORWARDING, BUG FIX
	regfile register_file(Da, Db, Dw, Rn, Ab, Rd, RegWrite, clk); // setting to negative may cause slight issues ALL CAPS
	
	// Execute Stage
	EX execute (.logic_result(execute_stage_result), .PC_select,
				.Da, .Db, .instr, .controlsigs, .clk, .reset);
	
	// Data Memory Stage
	MEM data_memory (.Dw, .logic_result(execute_stage_result), .Db, .instr, .controlsigs, .clk);
	
	// Writeback Stage
	WB writeback (.Rd, .RegWrite, .instr, .controlsigs);

endmodule

module CPU_testbench();
	parameter ClockDelay = 50000;

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
		while (PCPrev != PC) begin
			@(posedge clk); 
			PCPrev <= PC;
			@(posedge clk);
		end
		$stop;
	end
endmodule