-- 1
-- a) [1, 3, 3, 4, 5]
-- b) 7
-- c) [[], ['c']]
-- d) 4
-- e) [1, 4, 7]
-- f) "CDEF"
-- g) [(Int, String)]
-- h) (++) :: [a] -> [a] -> [a]
-- i) take :: Int -> [a] -> [a]
-- j) filter :: (a -> Bool) -> [a] -> [a]

-- 2
intersperse :: a -> [a] -> [a]
intersperse n [] = []
intersperse n [x] = [x]
intersperse n (x:xs) = x:n:(intersperse n xs)

-- 3.a)
group :: String -> [String]
group [] = []
group (x:xs) = [x : takeWhile (==x) xs] ++ group (dropWhile (==x) xs)

-- 3.b)
-- group' :: Eq a => [a] -> [[a]]
