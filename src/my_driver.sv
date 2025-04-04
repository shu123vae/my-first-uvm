
`ifndef MY_DRIVER
`define MY_DRIVER

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "my_transaction.sv"


class my_driver extends uvm_driver#(my_transaction);
	`uvm_component_utils(my_driver)
	virtual add_if vif;
	//my_transaction req;
	int count=0;

	function new(string name="my_driver",uvm_component parent);
		super.new(name,parent);
		`uvm_info("my_driver","the my_driver new is called!",UVM_LOW)
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual add_if)::get(this, "", "add_if", vif))
    			`uvm_info("my_driver", "Virtual interface not set",UVM_LOW)
		`uvm_info("my_driver","the my_driver build_phase is called!",UVM_LOW)
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("my_driver","the my_driver connect_phase is called!",UVM_LOW)
	endfunction

	virtual task run_phase(uvm_phase phase);
		`uvm_info("my_driver","the my_driver run_phase is called!",UVM_LOW)
		forever begin
		count++;
		`uvm_info("my_driver", $sformatf("the count = %0d",count),UVM_LOW)
    		seq_item_port.get_next_item(req);
    		vif.a <= req.a;
    		vif.b <= req.b;
    		@(posedge vif.clk);
    		seq_item_port.item_done();
  		end
	endtask
endclass

`endif