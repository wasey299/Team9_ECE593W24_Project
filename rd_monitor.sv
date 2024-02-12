class rd_monitor extends uvm_monitor;
 `uvm_component_utils(rd_monitor)
 
virtual fifo_if.RD_MON r_if;

rd_config r_cfg;

  uvm_analysis_port #(trans) rd_port;

function new(string name = "r_monitor",uvm_component parent);
 super.new(name,parent);
rd_port=new("rd_port",this);
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
     forever
       collect_data();
  endtask
  task collect_data();
    trans t;
    t=trans::type_id::create("t");
    //repeat(2)
    @(r_if.rd_mon);
    
   // if(r_if.rd_mon.read_enable)
     // begin
    t.read_enable=r_if.rd_mon.read_enable;
    t.full=r_if.rd_mon.full;
    t.empty=r_if.rd_mon.empty;
    t.data_out=r_if.rd_mon.data_out;
    t.read_enable=r_if.rd_mon.read_enable;
    
    // @(r_if.rd_mon);                    
    
    `uvm_info("rd mon",$sformatf("print from rd_mon \n %p",t.sprint()),UVM_LOW)
   
    rd_port.write(t);
     //end
  endtask


endclass