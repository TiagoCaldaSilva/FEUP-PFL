
data Map k a =  Empty
              | Node k a (Map k a) (Map k a)
              deriving Show

empty :: Map k a
empty = Empty

insert :: Ord k => k -> a -> Map k a -> Map k a
insert k v Empty = (Node k v Empty Empty)
insert k v (Node kk vv left right)
          | k == kk = Node kk vv left right
          | k > kk = Node kk vv left (insert k v right)
          | otherwise = Node kk vv (insert k v left) right

maplookup :: Ord k => k -> Map k a -> Maybe a
maplookup k Empty = Nothing
maplookup k (Node key value left right)
          | k == key = Just value
          | k > key = maplookup k right
          | otherwise = maplookup k left
