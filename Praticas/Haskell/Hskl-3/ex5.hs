my_max, my_max', my_min, my_min' :: Ord a => [a] -> a
my_max l = foldl1 max l
my_max' l = foldr1 max l
my_min l = foldl1 min l
my_min' l = foldr1 min l

my_foldl1, my_foldr1 :: (a -> a -> a) -> [a] -> a
my_foldl1 f x = foldl f (head x) (tail x)
my_foldr1 f x = foldr f (last x) (init x)
