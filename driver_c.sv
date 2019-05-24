//================================//
//Date:24-may-2019
//Version number: 1
//Author: Krishna
//Filename: driver_c.sv
//Description: This driver class will use drive_signals() method to drive data on to interface with respect to protocol.
//===============================//
class driver_c extends uvm_driver#(trans);
 
  virtual interface eth_if vif;
    
  bit sop;
  bit eop;
  int high_bytes;
  int msb_high_bytes;
  int packet_size;

    `uvm_component_param_utils_begin(driver_c)    
  `uvm_component_utils_end
  
   function new(string name = "driver_c",uvm_component parent = null);
    super.new(name,parent);
  endfunction : new
  
function void build_phase(uvm_phase phase);
  

  super.build_phase(phase);
  `uvm_info("BUILD_PHASE", $sformatf("Entered in build phase for interface & clock"), UVM_MEDIUM)

  if(!(uvm_config_db#(virtual eth_if)::get(this,"","vif",vif)&& vif != null)) begin
    `uvm_fatal("NOVIF",{"Virtual Interface must be set for : ", get_full_name(),".vif"});
  end
      
  endfunction : build_phase

task run_phase(uvm_phase phase);

  `uvm_info("RUN_PHASE", $sformatf(" Start of Driver in run_phase"), UVM_MEDIUM)
  while(1)
    begin
      $display("GET NEXT ITEM");
      seq_item_port.get_next_item(req);
      $display("DRIVING Signals");
      drive_signals(req);
      seq_item_port.item_done();
      `uvm_info(get_full_name(), $sformatf("Item at DRIVER:\n%s",
        req.sprint()), UVM_MEDIUM)
    end

endtask

    task drive_signals(trans trans_c);
  int packet_size;
  int high_bytes;
  int msb_high_bytes;
 
  `uvm_info(get_name(),$psprintf("Transaction is driven from driver \n %p",req.tx_data),UVM_MEDIUM)
    //1. Reset
	  @(posedge vif.clk) begin
         if (!vif.rst_n)
		   begin
             vif.sop <= 1'b0;
			 vif.eop <= 1'b0;
			 vif.data_valid <= 8'b0;
			 vif.tx_data <= 64'b0;
			 vif.tx_error <= 1'b0;
		   end
		else
		  begin
		     packet_size = trans_c.tx_data.size();
             high_bytes =  packet_size/2; //quotient will returned, used for lsb bytes
			 vif.data_valid = 'b0;
             for (int i = 0; i<high_bytes; i++)
			   begin
				 vif.sop <= 1'b1;
                 vif.tx_data <= trans_c.tx_data[i];
				 vif.data_valid <= 8'b1111_1111;
			   end
			msb_high_bytes = packet_size % 2; //reminder will be returned, used for msb bytes for transfer
            vif.data_valid = 'b0;//just cleaning up all the byte enables before validating msb bytes. 
			vif.data_valid = ('b1<<msb_high_bytes) - 1'b1;
            for(int j=0; j<msb_high_bytes;j++) begin
              vif.tx_data<=trans_c.tx_data[j];
            end
			 vif.eop <= 1'b1;//eop should be sent after the data packet
             vif.tx_error <= 1'b0;			 
		   end
        trans_c.tx_data.delete();
      end
endtask
 
endclass : driver_c