algarismos :: Int -> [Int]
algarismos x
           | x < 10 = [x]
           | otherwise = algarismos(x `div` 10) ++ [x `mod` 10]
