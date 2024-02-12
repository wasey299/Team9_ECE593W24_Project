class env_config extends uvm_object;
`uvm_object_utils(env_config)
  wr_config w_cfg;
  rd_config r_cfg;

  function new(string name = "env_config");
    super.new(name);
  endfunction
endclass