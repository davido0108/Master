declare
fun {FreeSet Expr}
   case Expr of
      nil then nil
   [] lam(X Y) then {FreeSet Y}
   [] apply(X Y) then {Append {FreeSet X} {FreeSet Y}}
   [] let(X#Y Z) then
      if {And X==Y X==Z} then nil
      else if X==Z then {FreeSet Y}
	   else if  X==Y then {FreeSet Z}
		else
		   {Append {FreeSet Y} {FreeSet Z}}
		end
	   end
      end
   [] X then [X]
   end
end

{Browse {FreeSet apply(x let(x#y x))}}
{Browse {FreeSet apply(y apply(let(x#x x)y))}}