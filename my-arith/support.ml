open Format

module Error = struct
  exception Exit of int (* dup definition? *)

  type info = INFO of string * int * int
  let createInfo f l c = INFO(f,l,c)
  let printInfo info = 
    match info with
    INFO(f,l,c) -> 
      print_string f; print_string ":";
      print_int l; print_string "." ;
      print_int c; print_string ":"

  let errf f = 
    print_flush();
    open_vbox 0;
    open_hvbox 0; f(); print_cut(); close_box(); print_newline();
    raise (Exit 1)

  let err s = errf (fun() -> print_string "Error: "; print_string s)
  
  (*  *)
  let print_err_info info s = 
    printInfo info; print_string s; print_newline(); raise (Exit 1)
end