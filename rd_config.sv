class rd_config extends uvm_object;
 `uvm_object_utils(rd_config)
 virtual fifo_if  f_if;

bit is_active;
function new(string name = "rd_config");
super.new(name);
endfunction
endclass
