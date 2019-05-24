//Sequence_item
class trans extends uvm_sequence_item;


  rand logic [63:0] tx_data[];
  rand logic [3:0] payload_sz;

  constraint c_pld_size {payload_sz > 'd17; payload_sz < 'd10000;}
 constraint c_tx_dt_size {tx_data.size() == payload_sz; solve payload_sz before tx_data;}
  
`uvm_object_utils_begin(trans)
  `uvm_field_int(payload_sz, UVM_ALL_ON )
  `uvm_field_array_int(tx_data, UVM_ALL_ON )
`uvm_object_utils_end
  
  
  function new(string name = "trans", uvm_component parent = null);
    super.new(name);
   `uvm_info("tx_data of trans",$sformatf("tx_data.size %d",tx_data.size()), UVM_MEDIUM)
  endfunction


endclass
