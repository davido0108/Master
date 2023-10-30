declare
Cnt={NewCell 0}

declare
fun {NewId}
   Cnt:=@Cnt+1
   {String.toAtom{Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

declare
Dic = {Dictionary.new}


fun {Rename Expr}
   case Expr of nil then nil
   [] lam(X Y) then lam({Rename X} {Rename Y})
   [] apply(X Y) then apply({Rename X} {Rename Y}) 
   [] let(X#Y Z) then let({Rename X}#{Rename Y}{Rename Z})
   [] X then 
      if {Dictionary.member Dic X} then
	 {Dictionary.get Dic X}
      else
	 {Dictionary.put Dic X {NewId}}
	 {Dictionary.get Dic X}
      end
   end
end

{Browse {Rename lam(z lam(x z))}}
%{Browse {Rename let(id#lam(z z) apply(id y))}}