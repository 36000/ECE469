module D_FF_e(q, d, enable, reset, clk);
 output reg q;
 input d, enable, reset, clk;
 
 always_ff @(posedge clk)
 if (reset)
 q <= 0;
 else if (enable)
 q <= d; // On enable, set to d
endmodule 