myMerge :: Ord a => [a] -> [a] -> [a]
myMerge [] y = y
myMerge (x:xs) [] = [x]
myMerge (x:xs) (y:ys)
          | x <= y = myMerge xs (x:y:ys)
          | otherwise = y: myMerge (x:xs) ys

myMerge' :: Ord a => a -> [a] -> [a]
myMerge' x [] = [x]
myMerge' x (y:ys)
          | x <= y = x:y:ys
          | otherwise = y: myMerge' x ys

msort :: Ord a => [a] -> [a]
msort [] = []
msort (x:[]) = [x]
msort x = myMerge (msort (fst m2)) (msort (snd m2))
        where m2 = metades x

metades :: [a] -> ([a], [a])
metades x = (take half x, drop half x)
          where half = (length x) `div` 2
