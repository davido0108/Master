declare
fun {Zip Xs#Ys}
   case Xs#Ys
   of nil#nil then nil
   [] (X|Xs)#(Y|Ys) then
      (X#Y)|{Zip Xs#Ys}
   end
end

{Browse {Zip [a b c]#[1 2 3]}}

declare
fun {UnZipX XY}
   case XY
   of nil then nil
   [] X#Y|XY then
      X|{UnZipX XY}
   end
end

declare
fun {UnZipY XY}
   case XY
   of nil then nil
   [] X#Y|XY then
      Y|{UnZipY XY}
   end
end

declare
fun {UnZip XY}
   {UnZipX XY}#{UnZipY XY}
end

{Browse {UnZip [a#1 b#2 c#3]}}
