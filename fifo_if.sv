interface fifo_if(input clk_write,clk_read);

  logic rst;
  logic write_enable,read_enable;
  logic full,empty;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic almost_empty;
  logic almost_full;

clocking wr_drv @(posedge clk_write);
 default input #1 output #1;
  output rst;
  output write_enable;
  output data_in;
  input full;
  
endclocking

clocking wr_mon @(posedge clk_write);
default input #1 output #1;
  input rst;
  input write_enable;
  input data_in;
endclocking

clocking rd_drv @(posedge clk_read);
 default input #1 output #1;
  output read_enable;
  input empty;
endclocking

clocking rd_mon @(posedge clk_read);
default input #1 output #1;
  input read_enable;
  input data_out;
  input full;
  input empty;
  input almost_empty;
  input almost_full;
endclocking

modport WR_DRV(clocking wr_drv);
modport WR_MON(clocking wr_mon);
modport RD_DRV(clocking rd_drv);
modport RD_MON(clocking rd_mon);
endinterface

module AsyncFIFO (
    input logic clk_write,
    input logic clk_read,
    input logic rst,
    input logic [7:0] data_in,
    input logic write_enable,
    input logic read_enable,
    output logic [7:0] data_out,
    output logic full,
    output logic empty,
    output logic almost_full,
    output logic almost_empty
);

    parameter DEPTH = 256;  

    logic [7:0] memory [0:DEPTH-1];
    logic [$clog2(DEPTH):0] front_index, rear_index;
    logic [$clog2(DEPTH):0] count;

    always_ff @(posedge clk_write or posedge clk_read or negedge rst) 
    begin
        if (rst) 
        begin
            front_index <= 0;
            rear_index <= 0;
            count <= 0;
        end

        else if (write_enable && !full) 
        begin
            memory[rear_index] <= data_in;
            rear_index <= (rear_index == DEPTH-1) ? 0 : rear_index + 1;
            count <= count + 1;
        end 
        
        else if (read_enable && !empty) 
        begin
            data_out <= memory[front_index];
            front_index <= (front_index == DEPTH-1) ? 0 : front_index + 1;
            count <= count -1;
        end    
    end


    assign almost_full = (count == DEPTH-2)?1:0;
    assign almost_empty = (count == 1)?1:0;
    assign full=(count == DEPTH-1)?1:0;
    assign empty = (count == 0)?1:0;


endmodule
