declare
fun {Eval Expr}
   case 
   Expr of nil then 0
   [] add(X Y) then {Eval X}+{Eval Y}
   [] mul(X Y) then {Eval X}*{Eval Y}
   [] int(X) then X
   end
end

{Browse {Eval add(int(1) mul(int(3)int(4)))}}