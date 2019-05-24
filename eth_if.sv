//================================//
//Date:24-may-2019
//Version number: 1
//Author: Krishna
//Filename: eth_if.sv
//Description: This is interface where protocol related signals are defined.
//===============================//
interface eth_if(input bit clk, rst_n);


logic [7:0]  data_valid;
logic [63:0] tx_data;
logic sop;
logic eop;

logic tx_error;

endinterface
