class wr_sequencer extends uvm_sequencer #(w_trans);
  `uvm_component_utils(wr_sequencer)

 function new(string name = "wr_sequencer",uvm_component parent);
    super.new(name,parent);
endfunction
endclass
