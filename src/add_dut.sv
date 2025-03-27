`ifndef ADD_DUT
`define ADD_DUT

module add_dut(
  	input clk,
	input rst_n,
  	input [7:0] a,
  	input [7:0] b,
	output reg v,
  	output reg [8:0] c
	
);
  reg [8:0] n_c;
  reg n_v;

  always @(posedge clk) begin
	
	if(!rst_n)begin
	c <= 0;
	v <=0;
	end 
	else begin
    	c <= n_c;
	v <= n_v;
	end
	$display("[add_dut] Time = %t: a = %0d, b = %0d, c = %0d, v=%0d", $time, a, b, c,v);
  end


 always @(*)begin
	n_c=a+b;
	n_v=1;
 end

endmodule

`endif
