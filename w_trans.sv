class w_trans extends uvm_sequence_item;
  `uvm_object_utils(w_trans)
 rand bit rst;
  rand bit write_enable;
  rand bit [7:0]data_in;
  
  constraint C1{ rst dist{1:=90,0:=10};}
  

  function new(string name = "w_trans"); 
  super.new(name);
endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("wr_en",this.write_enable,1,UVM_DEC);
    printer.print_field("data_in",this.data_in,8,UVM_DEC);

  endfunction
    

endclass

