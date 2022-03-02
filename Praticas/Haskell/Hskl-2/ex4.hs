divprop :: Integer -> [Integer]
divprop x = [n | n <- [1..x - 1], x `mod` n == 0]
