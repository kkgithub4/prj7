//=========agent====
class agent_c extends uvm_agent;
  sequencer_c sequencer;
  driver_c driver;

  uvm_active_passive_enum agent_is_active = UVM_ACTIVE;
  
    `uvm_component_param_utils_begin(agent_c )
    `uvm_field_object(sequencer , UVM_DEFAULT)
    `uvm_field_object(driver    , UVM_DEFAULT)
    `uvm_field_enum (uvm_active_passive_enum, agent_is_active,      UVM_DEFAULT)
  `uvm_component_utils_end


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

   if(agent_is_active == UVM_ACTIVE) begin
      sequencer = sequencer_c::type_id::create("sequencer", this);
      
      driver    = driver_c::type_id::create("driver", this);
      
   end
    
  endfunction : build_phase
 
  virtual function void connect_phase(uvm_phase phase);
    if(agent_is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
     endfunction : connect_phase
endclass : agent_c

