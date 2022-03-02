myAnd' :: [Bool] -> Bool
myAnd' lista = all (\x -> x) lista

myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && myAnd xs

myOr' :: [Bool] -> Bool
myOr' lista = any (\x -> x) lista

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat(xs)

myConcat' :: [[a]] -> [a]
myConcat' (x:xs) = foldr (++) x xs

myReplicate :: Int -> a -> [a]
myReplicate 0 x = []
myReplicate 1 x = [x]
myReplicate n x = x : myReplicate (n - 1) x

alineaE :: [a] -> Int -> a
alineaE l 0 = head l
alineaE l n = alineaE (tail l) (n - 1)

alineaE' :: [a] -> Int -> a
alineaE' l n = head [ y | (y, i)<-zip l [0..n], i == n]

myElem :: Eq a => a -> [a] -> Bool
myElem n [] = False
myElem n (x:xs) = (n == x) || myElem n xs

myElem' :: Eq a => a -> [a] -> Bool
myElem' n l = any(\a -> a == n) l
