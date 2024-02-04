module AsyncFIFO_tb();
  logic wr_clk,rd_clk,RD,WR,Rst;
  logic [7:0] dataIn;
  logic [7:0] dataOut;
  logic EMPTY;
  logic FULL;
  logic almost_full;
  logic almost_empty;
  
  AsyncFIFO FIFO_dut 
    (.clk_write(wr_clk),.clk_read(rd_clk),.data_in(dataIn),.read_enable(RD),.write_enable(WR),.data_out(dataOut),.rst(Rst),.empty(EMPTY),.full(FULL), .almost_empty(almost_empty),.almost_full(almost_full));
  
  task intialize;
    wr_clk = 1'b0;
    rd_clk=1'b0;
    dataIn = 8'h0;
    RD = 1'b0;
    WR = 1'b0;
    Rst = 1'b0;
  endtask

  task data(input [7:0]A);
    @(posedge wr_clk or rd_clk) dataIn=A;
  endtask
  
  always #10 wr_clk = ~wr_clk; 
  always #10 rd_clk = ~rd_clk;
  
  initial
  begin
    intialize;
    repeat (10) @ (negedge wr_clk or rd_clk); 
    Rst = 1'b1;
    repeat (10) @ (negedge wr_clk or rd_clk); 
    Rst = 1'b0;
    WR = 1'b1;
    data(8'h0);
    repeat (20) @ (negedge wr_clk or rd_clk); 
    data(8'h1);
    repeat (20) @ (negedge wr_clk or rd_clk); 
    data(8'h2);
    repeat (20) @ (negedge wr_clk or rd_clk); 
    data(8'h3);
    repeat (20) @ (negedge wr_clk or rd_clk); 
    data(8'h4);
    repeat (20) @ (negedge wr_clk or rd_clk); 
    WR = 1'b0;
    RD = 1'b1; 
    repeat (200) @ (negedge wr_clk or rd_clk); ; 
    $stop();
  end 
  
  initial
  begin
    $monitor("rd_clk=%b,RD=%b,WR=%b,wr_clk=%b,Rst=%b,dataIn=%b,dataOut=%b,EMPTY=%b,FULL=%b,almost_full=%b,almost_empty=%b",rd_clk,RD,WR,wr_clk,Rst,dataIn,dataOut,EMPTY,FULL,almost_full,almost_empty);
  end
endmodule