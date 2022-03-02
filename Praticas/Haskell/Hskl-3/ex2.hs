dec2int :: [Int] -> Int
dec2int (x:xs) = foldl (\x y-> 10*x + y) x xs
