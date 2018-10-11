module decoder5_32a (out, in, enable);

input logic [4:0] in;
input logic enable;
output logic [31:0] out;
logic [9:0] all_in;
genvar i, j, k, l, m, n, o;

generate
	for(n=0; n<4; n++) begin : bufs
	 buf #50 buf1(all_in[n], in[n]);
	end
endgenerate

generate
	for(o=0; o<4; o++) begin : nots
	 not #50 not1(all_in[4+o], in[o]);
	end
endgenerate

generate
	for(i=0; i<2; i++) begin : bit1
	 for(j=0; j<2; j++) begin : bit2
	  for(k=0; k<2; k++) begin : bit3
	   for(l=0; l<2; l++) begin : bit4
	    for(m=0; m<2; m++) begin : bit5
		  and6_1(out[i+j*2+k*4+l*8+m*16], all_in[5*i], all_in[1+5*j], all_in[2+5*k], all_in[3+5*l], all_in[4+5*m], enable);
	    end
	   end
	  end
	 end
	end
endgenerate


endmodule
