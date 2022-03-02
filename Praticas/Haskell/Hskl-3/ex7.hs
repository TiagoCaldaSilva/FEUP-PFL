my_maismais :: [a] -> [a] -> [a]
my_maismais l ll = foldr (:) ll l

my_concat :: [[a]] -> [a]
my_concat l = foldr (++) [] l

my_reverse :: [a] -> [a]
my_reverse l = foldr (\x y -> y++[x]) [] l

my_reverse' :: [a] -> [a]
my_reverse' l = foldl (\x y -> y:x) [] l

my_elem :: Eq a => a -> [a] -> Bool
my_elem x l = any (x ==) l
