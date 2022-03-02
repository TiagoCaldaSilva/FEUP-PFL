divprop :: Integer -> [Integer]
divprop x = [n | n <- [1..x - 1], x `mod` n == 0]

perfeitos :: Integer -> [Integer]
perfeitos x = [ xi | xi<-[1..x], sum (divprop xi) == xi]
