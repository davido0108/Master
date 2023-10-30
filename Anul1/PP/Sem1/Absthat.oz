declare
fun {Absthat X B}
   if B==true then
      if X < 0 then ~X
          else X end
   else
      if X<0.0 then ~X
          else X end
   end
end

declare X B
X = ~1.4
{Int.is X B}
{Browse {Absthat X B}}