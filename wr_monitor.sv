class wr_monitor extends uvm_monitor;
 `uvm_component_utils(wr_monitor)
 
virtual fifo_if.WR_MON w_if;

wr_config w_cfg;

  uvm_analysis_port #(w_trans) wr_port;

function new(string name = "wr_monitor",uvm_component parent);
 super.new(name,parent);
wr_port=new("wrr_port",this);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(wr_config)::get(this,"","wr_config",w_cfg))
     `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

function void connect_phase(uvm_phase phase);
  w_if=w_cfg.f_if;
endfunction

  task run_phase(uvm_phase phase);
     forever
       collect_data();
  endtask
  task collect_data();
 
  w_trans t_h;
    t_h=w_trans::type_id::create("t_h");
   @(w_if.wr_mon);
    if(w_if.wr_mon.write_enable)
      begin
    t_h.rst=w_if.wr_mon.rst;
    t_h.write_enable=w_if.wr_mon.write_enable;
    t_h.data_in=w_if.wr_mon.data_in;
        
   
    `uvm_info("wr_mon",$sformatf("print from wr_drv \n %p",t_h.sprint()),UVM_LOW)
    wr_port.write(t_h);
      end
  endtask


endclass