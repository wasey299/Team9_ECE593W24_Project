
class wr_driver extends uvm_driver #(w_trans);
 `uvm_component_utils(wr_driver)


 wr_config w_cfg;
 virtual fifo_if.WR_DRV w_if;

function new(string name = "wr_driver",uvm_component parent);
 super.new(name,parent);
endfunction

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(wr_config)::get(this,"","wr_config",w_cfg))
     `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

virtual function void connect_phase(uvm_phase phase);
   w_if=w_cfg.f_if;
endfunction

   virtual task run_phase(uvm_phase phase);
    @(w_if.wr_drv);
    w_if.wr_drv.rst<=0;
    @(w_if.wr_drv);
    @(w_if.wr_drv);
    
     w_if.wr_drv.rst<=1;
    forever
       begin
         seq_item_port.get_next_item(req);
         drive(req);
         seq_item_port.item_done();
       end
  endtask
  
  task drive(w_trans t1_h);
    while(w_if.wr_drv.full)
    @(w_if.wr_drv);
    @(w_if.wr_drv);
    w_if.wr_drv.write_enable<=t1_h.write_enable;
    @(w_if.wr_drv);
    $display("///////////////------read_enable=%d--%d------/////////////",t1_h.write_enable,$time);
    w_if.wr_drv.data_in<=t1_h.data_in;

    
   `uvm_info("wr_drv",$sformatf("print from wr_drv \n %p",t1_h.sprint()),UVM_LOW)
    endtask
endclass

    