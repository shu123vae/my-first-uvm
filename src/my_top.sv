 `timescale 1ns/1ps

`include "uvm_macros.svh"
`include "my_test.sv"
`include "add_if.sv"
`include "add_dut.sv"
import uvm_pkg::*;


module my_top;
	logic rst_n=0;
  	logic clk = 0;


  	add_if dif(clk,rst_n);
  	add_dut dut(.clk(clk), .rst_n(rst_n), .a(dif.a), .b(dif.b), .v(dif.v),.c(dif.c));

	initial begin
		`uvm_info("my_top","my_top,begin!",UVM_LOW)
		uvm_config_db#(virtual add_if)::set(null, "*", "add_if", dif);
		run_test("my_test");
		`uvm_info("my_top","my_top,end!",UVM_LOW)
	end

  	always #5 clk = ~clk;
	
	initial begin	
		rst_n=1;
    		#1000 
		$finish;
  	end

endmodule