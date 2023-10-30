declare
fun {Numerator N K}
   if K == 0 then 1
   else (N-K+1) * {Numerator N K-1}
   end
end

%{Browse {Numerator 10 3}}

declare
fun {Denominator N}
   if N == 0 then 1
   else N * {Denominator N-1}
   end
end   

declare
fun {Comb N K}
   if K == 0 then 1
   else
      {Numerator N K} div {Denominator K}
   end
end

%{Browse {Comb 3 2}}



declare
fun {Comb2 N K}
   if K == 0 then 1.0
   else
      {Int.toFloat (N-K+1)} / {Int.toFloat K} * {Comb2 N K-1}
   end
end

{Browse {Comb2 10 2}} 