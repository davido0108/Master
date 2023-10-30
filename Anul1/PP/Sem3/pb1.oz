declare
fun {Member Xs Y}
   case Xs
   of nil then false
   [] X|Xs then
      if X==Y then true
      else {Member Xs Y}
      end
   end
end

{Browse {Member [a b c] d}}