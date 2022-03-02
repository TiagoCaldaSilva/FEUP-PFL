-- 1
-- a) [[1, 2, 3], [4], [5]]
-- b) 5
-- c) [8, 6, 4, 2, 0]
-- d) 9
-- e) [(1, 1), (2, 1), (3, 1), (4, 1), (2, 2), (3, 2), (4, 2)]
-- f) [2, 4, 8, 16, 32]
-- g) [2^x -1 | x<-[1..10]]
-- h) 15
-- i) ([Bool], [Char])
-- j) p :: a -> b -> (a, b)
-- k) h :: Eq a => [a] -> [a] -> [a]
-- l) feql :: Eq a => [a] -> Bool

import Data.List

-- 2.a)
distancia :: Floating a => (a, a) -> (a, a) -> a
distancia (x1, y1) (x2, y2) = sqrt( ((x2-x1)^2) + ((y2-y1)^2) )

-- 2.b)
colineares :: (Floating a, Eq a) => (a, a) -> (a, a) -> (a, a) -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = d12 == d23
            where d12 = (y1 - y2) / (x1 - x2)
                  d23 = (y2 - y3) / (x2 - x3)

-- 3.a)
niguais :: Int -> a -> [a]
niguais 0 x = []
niguais n x = x : niguais (n-1) x

-- 3.b)
niguais' :: Int -> a -> [a]
niguais' n x = [x | n<-[1..n]]

-- Testar
niguais'' :: Int -> a  -> [a]
niguais'' n x = replicate n x

-- 4
merge :: Ord a => [a] -> [a] -> [a]
merge [] y = y
merge (x:xs) y = merge xs (insert x y)

-- 5
length_zip :: [a] -> [(Int, a)]
length_zip xs = [(length xs - x, y) | (x, y)<-zip [0..length xs - 1] xs]

-- 6
juntar :: Int -> [[Int]] -> [[Int]]
juntar x [] = [[x]]
juntar x xs = [insert x xss | xss<-xs]

removeEquals :: [[Int]] -> [[Int]]
removeEquals [] = []
removeEquals (x:xs)
              | any (==x) xs = removeEquals xs
              | otherwise = x : removeEquals xs

decompor :: Int -> [Int] -> [[Int]]
decompor 0 xs = []
decompor n xs
            | n < minimum xs = []
            | otherwise = filter (\x -> sum x == n) (removeEquals (concat [(juntar x (decompor (n-x) xs))  | x<-xs]))

decomporAux :: Int -> [Int] -> [Int] -> [[Int]]
decomporAux _ [] _ = []
decomporAux 0 _ x = [x]
decomporAux n lst@(x : xs) l
  | n <= 0 = []
  | otherwise = decomporAux (n - x) lst (x : l) ++ decomporAux n xs l

decompor' :: Int -> [Int] -> [[Int]]
decompor' n x = decomporAux n x []
