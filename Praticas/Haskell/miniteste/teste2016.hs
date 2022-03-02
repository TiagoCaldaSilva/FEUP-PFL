-- 1
-- a) [2, 3, 1, 4, 4]
-- b) [0, 10, 20, 30, 40]
-- c) [[], [3, 4], [5]]
-- d) 5
-- e) [1, 1, 1, 1, 1, 1]
-- f) [(1, 4), (2, 3), (3, 2)]
-- g) [2^x | x<-[0..6]]
-- h) 0
-- i) Num a => [(Bool, a)]
-- j) troca :: (a, b) -> (b, a)
-- k) g :: (Ord a, Num a) => a -> a -> a
-- l) [([a], a)]

-- 2.a)
ttriangulo :: (Num a, Eq a) => a -> a -> a -> String
ttriangulo x y z
            | x == y && y == z = "equilátero"
            | x == y  || y == z || x == z = "isósceles"
            | otherwise = "escaleno"

-- 2.b)
rectangulo :: (Num a, Ord a) => a -> a -> a -> Bool
rectangulo x y z = (head c)^2 + (last c)^2 == h^2
                where h = max (max x y) z
                      c = [n | n<-[x, y, z], n /= h]
-- 3
maiores :: Ord a => [a] -> [a]
maiores l = [x | (x, y)<-zip l (tail l), x > y]

-- 4.a)
somapares :: Num a => [(a, a)] -> [a]
somapares [] = []
somapares ((x, y):xs) = [x + y] ++ somapares xs

-- 4.b)
somapares' :: Num a => [(a, a)] -> [a]
somapares' l = [x + y | (x, y)<-l]

somapares'' ::  Num a => [(a, a)] -> [a]
somapares'' = map (uncurry (+))

-- 5.a)
itera :: Int -> (a -> a) -> a -> a
itera 0 f v = v
itera n f v = itera (n - 1) f (f v)

-- 5.b)
mult :: Int -> Int -> Int
mult x y = itera 1 (*y) x
