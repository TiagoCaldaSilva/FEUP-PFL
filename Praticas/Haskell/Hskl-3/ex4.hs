import Data.List

isort :: Ord a => [a] -> [a]
isort (x:xs) = foldr insert [x] xs
