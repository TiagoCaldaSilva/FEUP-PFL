import Set

union, intersect, difference :: Ord a => Set a -> Set a -> Set a

union x y = foldl (\x y -> insert y x) x (toList y)

intersect z y = foldl (\x y -> if(member y z) then insert y x else x) empty (toList y)

difference x z = foldl (\x y -> if(member y z) then x else insert y x) empty (toList x)
