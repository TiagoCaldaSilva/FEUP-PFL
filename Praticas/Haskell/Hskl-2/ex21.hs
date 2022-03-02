myMinimum :: Ord a => [a] -> a
myMinimum (x:[]) = x
myMinimum (x:xs)
                | validation = x
                | otherwise = myMinimum xs
                where validation = and [x < xi | xi <- xs]

myDelete :: Eq a => a -> [a] -> [a]
myDelete n [] = []
myDelete n (l:ls)
                | l == n = ls
                | otherwise = l : myDelete n ls

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort x = _min:ssort(myDelete _min x)
        where _min = myMinimum x
