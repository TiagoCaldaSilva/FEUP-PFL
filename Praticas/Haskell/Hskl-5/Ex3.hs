module Ex3 where

data Set a = St [a] deriving (Eq, Show)

member:: Eq a => a -> Set a -> Bool
member x (St xs) = elem x xs

insert :: Eq a => a -> Set a -> Set a
insert x (St xs)
      | elem x xs = St xs
      | otherwise = (St (x:xs))

delete :: Eq a => a -> Set a -> Set a
delete x (St xs) = St [z | z<-xs, z /= x]

union :: Eq a => Set a -> Set a -> Set a
union st1@(St x) (St y) = foldl (\s n -> if member n s then s else insert n s) st1 y

intersection :: Eq a => Set a -> Set a -> Set a
intersection st1@(St x) (St y) = foldl (\s n -> if member n st1 then insert n s else s) empty y
-- intersection (St x) (St y) = St [xs | xs<-x, elem xs y]

empty :: Set a
empty = St []

isEmpty :: Set a -> Bool
isEmpty (St x) = null x

fromList:: Eq a => [a] -> Set a
fromList z = foldl (\x y -> insert y x) empty z

toList:: Set a -> [a]
toList (St x) = x
