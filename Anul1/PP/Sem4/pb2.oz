declare
E1 = e1
E3 = e3
E4 = e4

declare
fun {IsMember List Z}
   case List
   of nil then false
   [] X#Y|List then
      
      if X == Z then true
      else
	 {IsMember List Z}
      end
   end
end

{Browse {IsMember [a#E1 b#y c#E3] y}}

declare
fun {Fetch List Z}
   case List
   of nil then Z
   [] X#Y|List then
      if X==Z then Y
      else
	 {Fetch List Z}
      end
      
   end
   
end

{Browse {Fetch [a#E1 b#y c#E3] d}}

declare
fun {AdjoinAux List A#B}
      case List
      of nil then nil
      [] X#Y|List then
	 if X == A then
	    List
	 else
	    X#Y | {AdjoinAux List A#B}
	 end
      end
end

declare
fun {Adjoin List A#B}
      A#B | {AdjoinAux List A#B}
end

{Browse {Adjoin [a#E1 b#y c#E3] d#E4}}

