curta :: [a] -> Bool
curta x
      | length x < 3 = True
      | otherwise = False

curta2 :: [a] -> Bool
curta2 x == [] = True
curta2 [x] = True
curta2 [x, x] = True
curta2 x = False
