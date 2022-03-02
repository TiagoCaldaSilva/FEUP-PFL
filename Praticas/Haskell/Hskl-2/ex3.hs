dotprod :: [Float] -> [Float] -> Float
dotprod x y = sum (zipWith (*) x y)
