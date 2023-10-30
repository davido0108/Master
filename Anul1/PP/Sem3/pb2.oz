declare
fun {Take Xs N}
   if N == 0 then nil
   else
      case Xs
      of nil then nil
      [] H|T then H|{Take T N-1}
      end
   end
end

{Browse {Take [1 4 3 6 2] 3}}

declare
fun {Drop Xs N}
   case Xs
   of nil then nil
   [] H|T then
      if N=<0 then H|{Drop T N-1}
      else {Drop T N-1}
      end
   end
end

{Browse {Drop [1 4 3 6 2] 3}}

