`ifndef MY_SEQUENCE
`define MY_SEQUENCE

`include "uvm_macros.svh"
`include "my_transaction.sv"
import uvm_pkg::*;

class my_sequence extends uvm_sequence#(my_transaction);
	`uvm_object_utils(my_sequence)
	int count=0;
	
	function new(string name="my_sequence");
	super.new(name);
	`uvm_info("my_sequence","the my_sequence new is called!",UVM_LOW)
	endfunction

	extern task body();

endclass

	task my_sequence::body();
	
	my_transaction tr;
	`uvm_info("my_sequence","the my_sequence task-body is called, begin!",UVM_LOW)
	repeat(51) begin
	count++;
	`uvm_info("my_sequence", $sformatf("the repeat count = %0d",count),UVM_LOW)
    	tr = my_transaction::type_id::create("tr");
    	start_item(tr);		
    	assert(tr.randomize());
	//`uvm_info("my_sequence", $sformatf("a=%0d, b=%0d, c=%0d",tr.a, tr.b, tr.c),UVM_LOW)
    	finish_item(tr);
	`uvm_info("my_sequence","the my_sequence task-body is called, end!",UVM_LOW)
  	end
	
	endtask

`endif