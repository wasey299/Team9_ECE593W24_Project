class rd_agent extends uvm_agent;
 `uvm_component_utils(rd_agent)

  rd_config r_cfg;
  rd_driver r_drvh;
  rd_monitor r_monh;
  rd_sequencer r_seqr;

function new(string name = "rd_agent",uvm_component parent);
 super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);

 if(!uvm_config_db #(rd_config)::get(this,"","rd_config",r_cfg))
     `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

 r_monh=rd_monitor::type_id::create("r_monh",this);

   begin
     r_drvh=rd_driver::type_id::create("r_drvh",this);
     r_seqr=rd_sequencer::type_id::create("r_seqr",this);
   end
endfunction

function void connect_phase(uvm_phase phase);
 r_drvh.seq_item_port.connect(r_seqr.seq_item_export);
endfunction
endclass