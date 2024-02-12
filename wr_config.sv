class wr_config extends uvm_object;
 `uvm_object_utils(wr_config)
 virtual fifo_if  f_if;

bit is_active;
function new(string name = "wr_config");
super.new(name);
endfunction
endclass
