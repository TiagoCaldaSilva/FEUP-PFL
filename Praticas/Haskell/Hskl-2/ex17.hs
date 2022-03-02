toBits :: Int -> [Int]
toBits x
       | x < 2 = [x]
       | otherwise = toBits(x `div` 2) ++ [x `mod` 2]
