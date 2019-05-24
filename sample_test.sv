//================================//
//Date:24-may-2019
//Version number: 1
//Author: Krishna
//Filename: sample_test.sv
//Description: This is sample test which is sending data on to interface by initiating the respective sequence.
//===============================//
  class sample_test extends base_test;

  `uvm_component_utils(sample_test)
   
   seq_trans seq1;
    
  function new(string name ="sample_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    seq1 = seq_trans::type_id::create("seq1");
       
  endfunction : build_phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $psprintf("TEST : Running the sequence "),UVM_LOW)
    seq1.start(env_c.agent.sequencer);
    
  endtask : run_phase

endclass : sample_test