module top();

import uvm_pkg::*;

bit clk_write;
bit clk_read;

always
 #10 clk_write = ~clk_write;
 always #10 clk_read = ~clk_read;
  fifo_if f_if(clk_write,clk_read);
  
  AsyncFIFO RTL(.clk_read(f_if.clk_read),     .clk_write(f_if.clk_write),.rst(f_if.rst),.write_enable(f_if.write_enable),.read_enable(f_if.read_enable),
           .data_in(f_if.data_in),.full(f_if.full),.empty(f_if.empty),
           .data_out(f_if.data_out),.almost_full(f_if.almost_full),.almost_empty(f_if.almost_empty));

initial
begin
$dumpfile("dump.vcd"); $dumpvars;
 uvm_config_db #(virtual fifo_if)::set(null,"*","fifo_if",f_if);
 
  run_test("test");
end
endmodule


