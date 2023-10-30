declare
fun {Insert Tree Integer}
   if Tree.1 < Integer then
      if Tree.3 == nil then
	 node(Tree.1 Tree.2 node(Integer nil nil))
      else
	 node(Tree.1 Tree.2 {Insert Tree.3 Integer})
      end
   else
      if Tree.2 == nil then
	 node(Tree.1 node(Integer nil nil) Tree.3)
      else
	 node(Tree.1 {Insert Tree.2 Integer} Tree.3)
      end
   end
end


{Browse {Insert node(3 node(2 nil nil) node(4 nil node(5 nil nil))) 7}}

declare
fun {Smallest Tree}
   if Tree.2 == nil then Tree.1
   else
      {Smallest Tree.2}
   end
end

{Browse {Smallest node(3 nil node(4 nil node(5 nil nil)))}}

declare
fun {Biggest Tree}
   if Tree.3 == nil then Tree.1
   else
      {Biggest Tree.3}
   end
end

{Browse {Biggest node(3 node(2 nil nil) node(4 nil node(5 nil nil)))}}

declare
fun {CompareBoth Tree}
   if Tree.2.1 < Tree.1 then
      if Tree.1 < Tree.3.1 then true
     else false
     end
   else false
   end
end

declare
fun {CompareLeft Tree}
   if Tree.2.1 < Tree.1 then true
   else false
   end
end

declare
fun {CompareRight Tree}
   if Tree.1 < Tree.3.1 then true
   else false
   end
end

declare
fun {IsSortedBST Tree}
   if Tree.2 == nil then
      if Tree.3 == nil then true
      else
	 if {CompareRight Tree} == false then false
	 else {IsSortedBST Tree.3}
	 end
      end
   else
      if Tree.3 == nil then
	 if {CompareLeft Tree} == false then false
	 else {IsSortedBST Tree.2}
	 end
      else
	 if {CompareBoth Tree} == false then false
	 else {And {IsSortedBST Tree.2} {IsSortedBST Tree.3}}
	 end
      end
   end
end

{Browse {IsSortedBST node(3 node(2 nil nil) node(4 nil node(5 nil nil)))}}


