class rd_driver extends uvm_driver #(trans);
     
  `uvm_component_utils(rd_driver)

 rd_config r_cfg;
 virtual fifo_if.RD_DRV r_if;

function new(string name = "rd_driver",uvm_component parent);
 super.new(name,parent);
endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(rd_config)::get(this,"","rd_config",r_cfg))
     `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

function void connect_phase(uvm_phase phase);
   r_if=r_cfg.f_if;
endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    
   
    forever
       begin
         seq_item_port.get_next_item(req);
         drive(req);
         seq_item_port.item_done();
       end
  endtask
  task drive(trans t);
      begin
        repeat(3)
        @(r_if.rd_drv);
    
     r_if.rd_drv.read_enable<=t.read_enable;
        $display("///////////////------read_enable=%d--%d------/////////////",t.read_enable,$time);
        repeat(4)
		@(r_if.rd_drv);
        $display("///////////////------read_enable=%d--%d------/////////////",t.read_enable,$time);
      end
  endtask
  


endclass