-- a) 1
-- b) 3,2,1,5,4
-- c) 2
-- d) 9
-- e) 6
-- f) 4
-- g) ([Int], [String])
-- h) (+) :: Num a => a -> a -> a
-- i) map :: (a -> b) -> [a] -> [b]
-- j) drop :: Int -> [a] -> [a]

import Data.Char
-- 2
--a
count :: (a->Bool) -> [a] -> Int
count f [] = 0
count f (x:xs)
            | f x = 1 + count f xs
            | otherwise = count f xs

--b
count' :: (a -> Bool) -> [a] -> Int
count' f l = length (filter f l)

--c
extras :: String -> Int
extras x = count (\z -> not (isLetter z)) x

-- 3
split :: Char -> String -> [String]
split c x
        | aux == x = [aux]
        | otherwise = [aux] ++ split c (tail(dropWhile (/= c) x))
        where aux = takeWhile (/= c) x
