
//=========top==========
  `timescale 1ns/1ps
`include "eth_if.sv";
`include "trans.sv";
`include "seq_trans.sv";
`include "driver_c.sv";
`include "sequencer_c.sv";
`include "agent_c.sv";
`include "env.sv";
`include "base_test.sv";
`include "sample_test.sv";

module top;

  import uvm_pkg::*;

  bit clk,rst_n;

  eth_if vif(.clk(clk),.rst_n(rst_n));

  
  initial begin
    //Clock generation
    clk = 1'b0;
    rst_n = 1'b0;
    #5 rst_n = 1'b1;
  end
  
  always begin
    #(5 * 1ps)  clk = 1; 
    #(5 * 1ps)  clk = 0; 
  end
      

   initial begin
    uvm_config_db #(virtual eth_if)::set(uvm_root::get(), "*", "vif", vif);
    run_test("sample_test");
    #20000 $finish;
  end 
endmodule
//======================