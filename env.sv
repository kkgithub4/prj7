//================================//
//Date:24-may-2019
//Version number: 1
//Author: Krishna
//Filename: env.sv
//Description: This is environment class where generally agent is build.
//===============================//
class env extends uvm_env;

  agent_c agent;
  `uvm_component_utils_begin(env)
    `uvm_field_object(agent ,  UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_component_utils_end
  function new(string name = "env", uvm_component parent = null);
   super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info(get_type_name(),"In Env Build Phase",UVM_DEBUG);
    agent = agent_c::type_id::create("agent",this);
	
   endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"In Connect Phase of Env",UVM_DEBUG);
  endfunction : connect_phase

  endclass : env 