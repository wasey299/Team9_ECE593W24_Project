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
            data_out <= 0;
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
