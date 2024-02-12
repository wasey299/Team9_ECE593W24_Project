class w_sequence extends uvm_sequence #(w_trans);
  `uvm_object_utils(w_sequence)
 
   function new(string name = "w_sequence");
     super.new(name);
   endfunction

task body();
  repeat(10)
    begin
   req=w_trans::type_id::create("req");
  
      start_item(req);
 
        
      assert( req.randomize() with {req.rst==0;});
      
     finish_item(req);
    end
endtask
   

endclass

class w_sequence1 extends w_sequence;
  `uvm_object_utils(w_sequence1)
 
  function new(string name = "w_sequence1");
     super.new(name);
   endfunction

task body();
  repeat(20)
    begin
   req=w_trans::type_id::create("req");
  
      start_item(req);
 
        
      assert( req.randomize());
      
     finish_item(req);
    end
endtask
   

endclass

