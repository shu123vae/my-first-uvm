`ifndef ADD_IF
`define ADD_IF

interface add_if(input clk, input rst_n);
  logic [7:0] a;
  logic [7:0] b;
  logic v;
  logic [8:0] c;
endinterface

`endif
