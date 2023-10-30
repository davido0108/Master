declare
fun {Position Xs Y}
   case Xs
   of X|Xs then
      if X == Y then 1
      else    1 + {Position Xs Y}
      end
   end 
end
{Browse {Position [a b c b] b}}

declare
fun {Position2 Xs Y Pos}
   case Xs
   of nil then 0
   [] X|Xs then
      if X == Y then Pos
      else {Position2 Xs Y Pos+1}
      end
   end 
end
{Browse {Position2 [a b c b] d 1}}