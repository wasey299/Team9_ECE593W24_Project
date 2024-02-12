class env extends uvm_env;
 `uvm_component_utils(env)

 wr_agent w_agth;
 rd_agent r_agth;

 env_config e_cfg;

 scoreboard sb;
 v_sequencer v_seqr;

function new(string name = "env",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 
if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
  `uvm_fatal("env_fatal","configuration not get")

uvm_config_db #(wr_config)::set(this,"*","wr_config",e_cfg.w_cfg);
w_agth=wr_agent::type_id::create("w_agth",this);

uvm_config_db #(rd_config)::set(this,"*","rd_config",e_cfg.r_cfg);
r_agth=rd_agent::type_id::create("r_agth",this);

v_seqr=v_sequencer::type_id::create("v_seqr",this);
sb=scoreboard::type_id::create("sb",this);

endfunction

function void connect_phase(uvm_phase phase);

  v_seqr.w_seqr=w_agth.w_seqr;
  v_seqr.r_seqr=r_agth.r_seqr;

  w_agth.w_monh.wr_port.connect(sb.w_fifo.analysis_export);
  r_agth.r_monh.rd_port.connect(sb.r_fifo.analysis_export);
endfunction
endclass