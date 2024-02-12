class r_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(r_sequence)
 
  function new(string name = "r_sequence");
     super.new(name);
   endfunction

task body();
  repeat(20)
    begin
   req=trans::type_id::create("req");
     
      start_item(req);
        
      assert( req.randomize());
      
     finish_item(req);
    end
endtask
   

endclass