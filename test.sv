class test extends uvm_test;
`uvm_component_utils(test)

  env_config e_cfg;
  wr_config w_cfg;
  rd_config r_cfg;
  v_sequence2 v_seqh;

 env env_h;

 function new(string name = "test",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  e_cfg=env_config::type_id::create("e_cfg");
  
   w_cfg=wr_config::type_id::create("w_cfg");
  if(!uvm_config_db #(virtual fifo_if)::get(this,"","fifo_if",w_cfg.f_if))
    w_cfg.is_active=1;
   e_cfg.w_cfg=w_cfg;

  r_cfg=rd_config::type_id::create("r_cfg");
  if(!uvm_config_db #(virtual fifo_if)::get(this,"","fifo_if",r_cfg.f_if))
   r_cfg.is_active=1;
   e_cfg.r_cfg=r_cfg;

  super.build_phase(phase);
  uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
  env_h=env::type_id::create("env_h",this);
endfunction
      
      task run_phase(uvm_phase phase);
        //repeat(2)
          begin
        phase.raise_objection(this);
        v_seqh=v_sequence2::type_id::create("v_seqh");
        v_seqh.start(env_h.v_seqr);
           // #100;
        phase.drop_objection(this);
            
          end
      endtask

endclass
