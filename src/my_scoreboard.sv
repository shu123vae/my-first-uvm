`ifndef MY_SCOREBOARD
`define MY_SCOREBOARD

`include "uvm_macros.svh"
`include "my_transaction.sv"
import uvm_pkg::*;


`uvm_analysis_imp_decl(_input)
`uvm_analysis_imp_decl(_output)
class my_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(my_scoreboard)
	uvm_analysis_imp #(my_transaction, my_scoreboard) analysis_export;

	//---------------
	uvm_analysis_imp_input #(my_transaction, my_scoreboard) imp_input;		//??????
	uvm_analysis_imp_output #(my_transaction, my_scoreboard) imp_output;		//??????

	int error_count = 0;
  	int total_count = 0;
	
	my_transaction que_input[$];	// ??????

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		analysis_export = new("analysis_export", this);
		imp_input = new("imp_input", this);
		imp_output = new("imp_output", this);
		`uvm_info("my_scoreboard","the my_scoreboard new is called!",UVM_LOW)
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("my_scoreboard","the my_scoreboard build_phase is called!",UVM_LOW)
	endfunction
	

	function void connect_phase(uvm_phase phase);
		`uvm_info("my_scoreboard","the my_scoreboard connect_phase is called!",UVM_LOW)
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("my_scoreboard","the my_scoreboard run_phase is called!",UVM_LOW)
	endtask


	function void write_input(my_transaction tr);
		`uvm_info("my_scoreboard","the my_scoreboard write_input is called!",UVM_LOW)
		que_input.push_back(tr);
   	endfunction

	function void write_output(my_transaction tr);
		`uvm_info("my_scoreboard","the my_scoreboard write_output is called!",UVM_LOW)
		if(tr.v ==1 && que_input.size()>0) begin
		my_transaction tr_input=que_input.pop_front();
		total_count++;
		if(tr.c != (tr_input.a+tr_input.b)) begin
		error_count++;
    		`uvm_error("CHECK", $sformatf("Mismatch! a=%0d + b=%0d = %0d (Expected %0d),total_count=%0d, error_count=%0d ",
			tr_input.a, tr_input.b, tr.c, tr_input.a+tr_input.b, total_count, error_count))
  		end
		else begin
		`uvm_info("CHECK",$sformatf("Match! a=%0d + b=%0d = %0d (Expected %0d)",
			tr_input.a, tr_input.b, tr.c, tr_input.a+tr_input.b),UVM_LOW);
		end
		end
    	endfunction


	function void write(my_transaction tr);
	`uvm_info("my_scoreboard",$sformatf("the my_scoreboard write is called! a=%0d + b=%0d = %0d",tr.a, tr.b, tr.c), UVM_LOW)
  	
	que_input.push_back(tr);
	if(tr.v ==1 && que_input.size()>0) begin
		my_transaction tr_input=que_input.pop_front();
		total_count++;
		if(tr.c != (tr_input.a+tr_input.b)) begin
		error_count++;
    		`uvm_error("CHECK", $sformatf("Mismatch! a=%0d + b=%0d = %0d (Expected %0d),total_count=%0d, error_count=%0d ",
			tr_input.a, tr_input.b, tr.c, tr_input.a+tr_input.b, total_count, error_count))
  		end
		else begin
		`uvm_info("CHECK",$sformatf("Match! a=%0d + b=%0d = %0d (Expected %0d)",
			tr_input.a, tr_input.b, tr.c, tr_input.a+tr_input.b),UVM_LOW)
		end
	end
	endfunction
	
	function void compare(my_transaction tr);
		`uvm_info("my_scoreboard","the my_scoreboard compare is called!",UVM_LOW)
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info("SUMMARY", $sformatf("Test cases: %0d, Errors: %0d",total_count, error_count), UVM_LOW)
	endfunction
endclass

`endif