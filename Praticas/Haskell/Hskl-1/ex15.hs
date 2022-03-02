media3 :: Ord a => a -> a-> a -> a
media3 x y z
          | mx >= z = max mn z
          | otherwise = mx
          where mx = max x y
                mn = min x y

newMedia :: Int -> Int -> Int -> Int
newMedia x y z = s - mx - mn
                 where s = x + y + z
                       mx = max (max x y) z
                       mn = min (min x y) z
