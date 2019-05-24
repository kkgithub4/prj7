//=========sequencer====
class sequencer_c extends uvm_sequencer#(trans);
   
  `uvm_component_utils(sequencer_c)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_name(),$psprintf("this is from sequencer_c"),UVM_MEDIUM) 
    this.print();
  endfunction : end_of_elaboration_phase

endclass : sequencer_c