module and6_1 (out, in);

input logic [5:0] in;
output logic out;
logic [3:0] w;

and #50 and1(w[0], in[0], in[1]);
and #50 and2(w[1], in[2], in[3]);
and #50 and3(w[2], w[0], w[1]);

and #50 and4(w[3], in[4], in[5]);

and #50 and5(out, w[2], w[3]);

endmodule
