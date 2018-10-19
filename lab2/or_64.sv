`timescale 1ns/10ps

// 64 bit or
module or_64(in, out);
  input logic [63:0] in;
  output logic out;
  logic [31:0] layer1out;
  logic [15:0] layer2out;
  logic [7:0] layer3out;
  logic [3:0] layer4out;
  logic [1:0] layer5out;

  genvar i;
  generate
    for (i=0; i < 32; i++ begin : first_layer
      or #50 or1Gates(layer1out[i], in[i*2], in[i*2+1]);
    end
    for (i=0; i < 16; i++ begin : second_layer
      or #50 or2Gates(layer2out[i], layer1out[i*2], layer1out[i*2+1]);
    end
    for (i=0; i < 8; i++ begin : third_layer
      or #50 or3Gates(layer3out[i], layer2out[i*2], layer2out[i*2+1]);
    end
    for (i=0; i < 4; i++ begin : fourth_layer
      or #50 or4Gates(layer4out[i], layer3out[i*2], layer3out[i*2+1]);
    end
    for (i=0; i < 2; i++ begin : fifth_layer
      or #50 or5Gates(layer5out[i], layer4out[i*2], layer4out[i*2+1]);
    end
  endgenerate

  or #50 lastOr(out, layer5out[0], layer5out[1]);

endmodule
