module Set where

data Set a = Empty-- conjunto vazio
           | Node a (Set a) (Set a) deriving Show


member :: Ord a => a -> Set a -> Bool
member x Empty = False
member x (Node y left right)
    | x == y = True
    | x > y = member x right
    | x < y = member x left

insert :: Ord a => a -> Set a -> Set a
insert x Empty = Node x Empty Empty
insert x (Node y left right)
    | x == y = Node y left right
    | x > y = Node y left (insert x right)
    | x < y = Node y (insert x left) right

empty :: Set a
empty = Empty

isEmpty :: Set a -> Bool
isEmpty Empty = True
isEmpty _ = False

toList :: Set a -> [a]
toList Empty = []
toList (Node x l r) = toList l ++ [x] ++ toList r

fromList :: Ord a => [a] -> Set a
fromList = foldr insert Empty
