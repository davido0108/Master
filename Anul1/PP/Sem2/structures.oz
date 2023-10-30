declare
fun lazy {Sieve L}
   case L of nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end

declare
fun lazy {Filter L H}
   case L of nil then nil
   [] A|As then
      if (A mod H) == 0 then {Filter As H}
      else A|{Filter As H}
      end
   end
end

declare
fun lazy {Gen N}
   N|{Gen N+1}
end

declare
fun {Prime}
   {Sieve {Gen 2}}
end

declare
fun {GetAfter L N}
   case L of nil then nil
   [] H|T then
      if (H > N) then H|{GetAfter nil N}
      else {GetAfter T N}
      end
   end
end

{Browse {GetAfter {Prime} 5}}