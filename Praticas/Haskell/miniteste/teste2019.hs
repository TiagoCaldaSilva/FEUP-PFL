-- 1
-- a) [[1, 2] [], [3, 4], [5]]
-- b) [5]
-- c) 2
-- d) [16, 20, 24, 28, 32]
-- e) [(3, 2), (4, 3), (5, 4), (5, 6), (6, 8), (7, 12)]
-- f) [[2, 8], [4, 6], []]
-- g) [(x, 6 - x) | x<-[0..6]]
-- h) 15
-- i) [(Char, String)]
-- j) f :: (Ord a, Num a) => a -> [a] -> Bool
-- k) ig :: Eq a => [a] -> Bool
-- l) fix :: Eq a => (a -> a) -> a -> Bool

-- 2.a)
pitagoricos :: Int -> Int -> Int -> Bool
pitagoricos x y z = sum c == h^2
                  where h = max (max x y) z
                        c = [ n^2 | n<-[x, y, z], n /= h]

-- 2.b)
hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt (a^2 + b^2)

-- 3.a)
diferentes :: Eq a => [a] -> [a]
diferentes [] = []
diferentes [x] = []
diferentes (x:y:xs)
            | x /= y = x : diferentes (y:xs)
            | otherwise = diferentes (y:xs)

-- 3.b)
diferentes' :: Eq a => [a] -> [a]
diferentes' x = [y | (y, z)<-zip x (tail x), y /= z]

-- 4
zip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
zip3 x y z = [(a, b, c) | ((a, b), c)<-zip aux z]
          where aux = zip x y

-- 5
partirAux :: Eq a => a -> [a] -> Int
partirAux _ [] = 0
partirAux c (x:xs)
              | c == x = 0
              | otherwise = 1 + partirAux c xs

partir :: Eq a => a -> [a] -> ([a], [a])
partir c x = (take n x, drop n x)
            where n = partirAux c x

-- 6

myMerge :: a -> [[[a]]] -> [[[a]]]
myMerge x [] = []
myMerge x (y:ys) = apart ++ together ++ myMerge x ys
            where apart = [[[x]] ++ y]
                  together = if length y == 1 then [[[x] ++ head y]]
                             else [[[x] ++ head y], tail y]

parts :: [a] -> [[[a]]]
parts [] = []
parts [x] = [[[x]]]
parts (x:xs) = myMerge x (parts xs)

parts':: [a] -> [[[a]]]
parts' [] = [[]]
parts' (x:xs) = [ [x]:ps | ps <- pss] ++ [ (x:p):ps| (p:ps) <- pss]
      where pss = parts' xs
