declare
fun {Position Xs Y}
   case Xs
   of nil then 1
   [] X|Xs then
      if X == Y then 1
      else    1 + {Position Xs Y}
      end
   end 
end
   
%{Browse {Position [a b c b] b}}

declare
fun {Position2 Xs Y}
   case Xs
   of {And (X== {List.last Xs}) (X!=Y)} then 0
   [] X|Xs then
      if X == Y then 1
      else    1 + {Position2 Xs Y}
      end
   end
   
end

{Browse {Position2 [a d c b c b] b}}
{Browse {List.last [a b c s]}}
  % {Browse {List.length [a b c]}}
 %  {Brose {List.