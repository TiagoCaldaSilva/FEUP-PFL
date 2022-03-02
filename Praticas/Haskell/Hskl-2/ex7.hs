primo :: Integer -> Bool
primo 1 = True
primo x = length (divprop  x) == 2

divprop :: Integer -> [Integer]
divprop x = [n | n <- [1..x], x `mod` n == 0]
