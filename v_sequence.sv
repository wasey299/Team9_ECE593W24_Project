class v_sequence extends uvm_sequence #(uvm_sequence_item);
 `uvm_object_utils(v_sequence)

  v_sequencer v_seqr;
  
  wr_sequencer w_seqr;
  rd_sequencer r_seqr;

  w_sequence w_seq;
  r_sequence r_seq;

function new(string name = "v_sequence");
  super.new(name);
endfunction

task body();

  if(!$cast(v_seqr,m_sequencer))
    `uvm_fatal("fatal","casting not happen")

   w_seqr=v_seqr.w_seqr;
  r_seqr=v_seqr.r_seqr;
endtask
                 
endclass

class v_sequence1 extends v_sequence;
  `uvm_object_utils(v_sequence1)
  
  function new(string name = "v_sequence1");
    super.new(name);
  endfunction
  task body();
    super.body();
    
                 w_seq=w_sequence::type_id::create("w_seq");
                 r_seq=r_sequence::type_id::create("r_seq");
    
                 fork
                   w_seq.start(w_seqr);
                   
                   r_seq.start(r_seqr); 
                 join
    
                                                  
endtask
endclass

class v_sequence2 extends v_sequence;
  `uvm_object_utils(v_sequence2)
  w_sequence1 w_seq1;
  
  function new(string name = "v_sequence2");
    super.new(name);
  endfunction
  task body();
    super.body();
    
    w_seq1=w_sequence1::type_id::create("w_seq1");
    r_seq=r_sequence::type_id::create("r_seq");
                 fork
                   w_seq1.start(w_seqr);
                   
                   r_seq.start(r_seqr); 
                 join
    
                                                  
endtask
endclass
