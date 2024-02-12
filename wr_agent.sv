class wr_agent extends uvm_agent;
 `uvm_component_utils(wr_agent)

   wr_config w_cfg;
 wr_driver w_drvh;
 wr_monitor w_monh;
 wr_sequencer w_seqr;

function new(string name = "wr_agent",uvm_component parent);
 super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);

 if(!uvm_config_db #(wr_config)::get(this,"","wr_config",w_cfg))
     `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

 w_monh=wr_monitor::type_id::create("w_monh",this);
   begin
     $display("DRIVER");
     w_drvh=wr_driver::type_id::create("w_drvh",this);
     w_seqr=wr_sequencer::type_id::create("w_seqr",this);
     $display("AFTER CREATING");
   end
endfunction

function void connect_phase(uvm_phase phase);
  $display("DRV_CONNECT");
  w_drvh.seq_item_port.connect(w_seqr.seq_item_export);
endfunction

endclass