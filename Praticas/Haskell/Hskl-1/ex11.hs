-- max3, min3 :: Ord a => a -> a -> a -> a
-- max3 x y z
--       | x <= y = if(y <= z) then z else y
--       | x > y = if(x <= z) then z else x
-- min3 x y z
--       | x <= y = if(x <= z) then x else z
--       | x > y = if(y <= z) then y else z
--
--
max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z =  if m >= z then m else z
              where m = max x y
min3 x y z =  if m <= z then m else z
              where m = min x y
