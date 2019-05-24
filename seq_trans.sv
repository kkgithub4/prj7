   
//=========sequence====
class seq_trans extends uvm_sequence#(trans);

  `uvm_object_utils(seq_trans)
 
  function new (string name = "seq_trans");
   super.new(name);
  endfunction : new
  
  trans trans_obj;

  task body();
    `uvm_info(get_type_name(), $psprintf(" %s sequence body is started... ", get_sequence_path()),UVM_LOW)
    `uvm_do(trans_obj)
    `uvm_info(get_type_name(), $psprintf(" %s sequence body is ended... ", get_sequence_path()),UVM_LOW)
     
  endtask
 
   virtual task pre_body();
     `uvm_info(get_type_name(), $psprintf(" %s sequence pre_body is ended... ", get_sequence_path()),UVM_LOW)
  endtask : pre_body
  
    virtual task post_body();
      `uvm_info(get_type_name(), $psprintf(" %s sequence post_body is ended... ", get_sequence_path()),UVM_LOW)
  endtask : post_body

endclass