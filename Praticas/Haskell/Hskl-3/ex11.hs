calcPi1, calcPi2 :: Int -> Double
calcPi1 x = sum( take x (zipWith (*) (zipWith (/) n d) s) )
          where n = repeat 4.0
                d = [1.0, 3.0..]
                s = cycle [1, -1]
calcPi2 x = sum( take x (zipWith (*) (zipWith (/) n (1:(d 2.0))) s))
          where n = 3:(repeat 4)
                d z = (z*(z+1.0)*(z+2.0)):d(z+2.0)
                s = 1:(cycle [1, -1])
