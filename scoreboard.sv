class scoreboard extends uvm_scoreboard;
 `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(w_trans) w_fifo;
  uvm_tlm_analysis_fifo #(trans) r_fifo;

  bit [7:0]q[$];
  w_trans w_t;
trans r_t;
  covergroup cg;
    C_W:coverpoint w_t.write_enable;
    C_W1:coverpoint w_t.data_in{bins b1[]={[0:50]};
                              bins b2[]={[51:100]};
                              bins b3[]={[101:$]};}
  endgroup
  covergroup cg1;
    C_R:coverpoint r_t.read_enable;
    C_R1:coverpoint r_t.full;
    C_R2:coverpoint r_t.empty;
  endgroup
  
function new(string name = "scoreboard",uvm_component parent);
  super.new(name,parent);
  w_fifo=new("wr_fifo",this);
  r_fifo=new("rd_fifo",this);
  cg=new();
  cg1=new();
endfunction
  task run_phase(uvm_phase phase);
   
   forever
      fork
        begin
          w_fifo.get(w_t);
          if(w_t.rst==1 && w_t.write_enable==1)
            q.push_back(w_t.data_in);
          cg.sample();
          $display("%p",q);
        end
         begin
           r_fifo.get(r_t);
           cg1.sample();
           if(r_t.read_enable==1)
             check_data(r_t);
           
         end
      join
  endtask
  
             function check_data( trans r_t1);
    bit [7:0]d;
    if(r_t1.read_enable)
      if(r_t1.data_out)
        begin
          d=q.pop_front();
        if(d==r_t1.data_out)
          $display("---------DATA MATCHED---------d=%d----,data_out=%d",d,r_t1.data_out);
        else
          $display("-----****----DATA NOT MATCHED---****------d=%d----,data_out=%d",d,r_t1.data_out);
        end
      
  endfunction
endclass
