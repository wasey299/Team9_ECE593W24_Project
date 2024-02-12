class trans extends uvm_sequence_item;
    `uvm_object_utils(trans)

    rand bit read_enable;
    bit [7:0] data_out;
    bit full, empty;
    bit [3:0] idle_cycles; 

    constraint C2 {
        read_enable dist {1:=50, 0:=50};
    }
    constraint idle_cycles_constraint {
      if(read_enable ) (idle_cycles == 4);
    }

    function new(string name = "trans");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("read_enable", this.read_enable, 1, UVM_DEC);
        printer.print_field("full", this.full, 1, UVM_DEC);
        printer.print_field("empty", this.empty, 1, UVM_DEC);
        printer.print_field("data_out", this.data_out, 8, UVM_DEC);
        printer.print_field("idle_cycles", this.idle_cycles, 4, UVM_DEC);
    endfunction
endclass
