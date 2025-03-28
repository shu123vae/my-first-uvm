`ifndef MY_TRANSACTION
`define MY_TRANSACTION

`include "uvm_macros.svh"
import uvm_pkg::*;

class my_transaction extends uvm_sequence_item;
rand logic [7:0] a;
rand logic [7:0] b;
logic v;
logic [8:0] c;

`uvm_object_utils_begin(my_transaction)
	`uvm_field_int(a,UVM_ALL_ON)
	`uvm_field_int(b,UVM_ALL_ON)
	`uvm_field_int(c,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="my_transaction");
	super.new(name);
	`uvm_info("my_transaction","the my_transaction new is called!",UVM_LOW)
endfunction

function string convert2string();
	return $sformatf("a=%0d, b=%0d, c=%0d", a, b, c);
endfunction

endclass

`endif