myIntersperse :: a -> [a] -> [a]
myIntersperse c (x:xs)
                  | length xs == 0  = [x]
                  | otherwise = x:c:myIntersperse c xs
