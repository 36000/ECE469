// forwarding logic
module Register_Forward();
	output logic [63:0] f_Da, f_Db;

	input logic [63:0] Da, Db, EX_Result, MEM_Result;
	input logic [4:0] Aa, Ab, EX_id, MEM_id;
	input logic EX_enable, MEM_enable;

	always_comb begin
		if (Aa == 5'd31)
			f_Da = Da;
		else if ((Aa == EX_id) & EX_enable)
			f_Da = EX_Result;
		else if ((Aa == MEM_id) & MEM_enable)
			f_Da = MEM_Result;
		else
			f_Da = Da;
			
		if (Ab == 5'd31)
			f_Db = Db;
		else if ((Ab == EX_id) & EX_enable)
			f_Db = EX_Result;
		else if ((Ab == MEM_id) & MEM_enable)
			f_Db = MEM_Result;
		else
			f_Db = Db;
	end
endmodule