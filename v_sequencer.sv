class v_sequencer extends uvm_sequencer #(uvm_sequence_item);
 `uvm_component_utils(v_sequencer)

 wr_sequencer w_seqr;
 rd_sequencer r_seqr;

function new(string name = "v_sequencer" ,uvm_component parent);
  super.new(name,parent);
endfunction
endclass