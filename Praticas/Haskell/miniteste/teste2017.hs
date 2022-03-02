-- 1
-- a) [1, 5, 4, 3]
-- b) [5, 6, 9]
-- c) [3, 1, 4, 4, 6]
-- d) [15, 18, 21, 24, 27, 30]
-- e) 4
-- f) [1, 2, 3, 4, 6, 9]
-- g) [1, 2, 3]
-- h) [(-1)^n * n | n<-[0..10]]
-- i) 8
-- j) ([Char], [Float])
-- k) fst :: (a, b) -> a
-- l) h :: Ord a => a -> a -> a -> Bool
-- m) f :: [a] -> a

-- 2
numEqual :: Eq a => a -> a -> a -> Int
numEqual x y z
            | x == y && y == z = 3
            | (x == y) || (y == z) || (x == z) = 2
            | otherwise = 0

-- 3
area :: Floating a => a -> a -> a -> a -> a -> a -> a
area a b c d p q  = (1/4.0) * sqrt (4 * (p^2) * (q^2) - ((b^2 + d^2 - a^2 - c^2)^2))

-- 4
enquantoPar :: [Int] -> [Int]
enquantoPar [] = []
enquantoPar xs
            | mod (head xs) 2 /= 0 = enquantoPar (tail xs)
            | otherwise = if length n1 >= length n2 then n1 else n2
              where n1 = takeWhile (\x -> mod x 2 == 0) xs
                    n2 = enquantoPar (dropWhile (\x -> mod x 2 == 0) xs)

-- 5
nat_zip :: String -> [(Int, Char)]
nat_zip x = zip [1..length x] x

-- 6.a)
quadrados :: [Int] -> [Int]
quadrados [] = []
quadrados (x:xs) = x^2 : quadrados xs

-- 6.b)
quadrados' :: [Int] -> [Int]
quadrados' x = [n^2 | n<-x]

-- 7
-- Verifica se está em ordem crescente
crescente :: [Int] -> Bool
crescente [] = True
crescente x = and [x <= y | (x, y)<-zip x (tail x)]

-- Remove pares iguais
rPI :: [[Int]] -> [[Int]]
rPI [] = []
rPI (x:xs)
        | any (==x) xs = rPI xs
        | otherwise = rPI xs ++ [x]

partes :: Int -> [[Int]]
partes 0 = [[]]
partes n = filter crescente (rPI (reverse pR))
        where pR = concat [juntar (partes x) (partes (n - x)) | x<-[1.. div n 2]] ++ [[n]]
              juntar x y = [n1 ++ n2 | n1 <-x, n2<-y]


partesAux :: Int -> [Int] -> [Int] -> [[Int]]
partesAux 0 _ x = [x]
partesAux _ [] _ = []
partesAux n lst@(x:xs) l
                | n < 0 = []
                | otherwise = partesAux (n - x) lst (x:l) ++ partesAux n xs l

partes' :: Int -> [[Int]]
partes' x = partesAux x [1..x] []
