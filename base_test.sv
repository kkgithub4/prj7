//================================//
//Date:24-may-2019
//Version number: 1
//Author: Krishna
//Filename: base_test.sv
//Description: This is base test for all the tests, where common variables related to tests are placed.
//===============================//
  class base_test extends uvm_test;
  
  env env_c;

  bit test_pass = 1;

  `uvm_component_utils_begin(base_test)
    `uvm_field_object(env_c,               UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_component_utils_end


  function new(string name ="base_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_c=env::type_id::create("env_c",this);  
  endfunction : build_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase); 
    super.end_of_elaboration_phase(phase); 
    uvm_top.print_topology(); 
  endfunction :end_of_elaboration_phase

  virtual function void report_phase(uvm_phase phase);
  endfunction : report_phase 
  
endclass : base_test