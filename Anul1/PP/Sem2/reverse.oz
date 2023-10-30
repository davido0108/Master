declare
fun {Reverse L1 L2}
   case L1
   of nil then L2
   [] H|T then {Reverse T H|L2}
   end
end

{Browse {Reverse ['I' 'want' 2 go 'there'] nil}}