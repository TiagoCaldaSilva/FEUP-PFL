primos :: [Int]
primos = crivo [2..]

crivo :: [Int] -> [Int]
crivo (p:xs) = p : crivo [x | x<-xs, x`mod`p/=0]

factores :: Int -> [Int]
factores 1 = []
factores x = k:factores (x `div` k)
            where k = (!!) primos i
                  i = until (\z -> (x `mod` ((!!) primos z)) == 0) (\z -> z + 1) 0
