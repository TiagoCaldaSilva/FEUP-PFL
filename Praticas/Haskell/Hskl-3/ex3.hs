my_zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
my_zipWith f [] y = []
my_zipWith f x [] = []
my_zipWith f (x:[]) (y:[]) = [f x y]
my_zipWith f (x:xs) (y:ys) = [f x y] ++ my_zipWith f xs ys
