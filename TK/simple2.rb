require 'tk'  
hello = TkRoot.new do  
  title "Hello World"  
  # the min size of window  
  minsize(400,400)  
end  

 TkLabel.new(hello) do  
  text 'Nadav'  
  foreground 'red'  
  pack { padx 45; pady 100; side 'left'}  
end  

TkButton.new do  
  text "EXIT"  
  command { exit }  
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)  
end 

Tk.mainloop  
