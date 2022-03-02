module Ex12(intercalar) where

-- intercalar :: a -> [a] -> [[a]]
-- intercalar x y = [(take z y) ++ [x] ++ (drop z y) | z<-[0..length y]]

intercalar :: a -> [a] -> [[a]]
intercalar x y = insertAt x y 0

insertAt :: a -> [a] -> Int -> [[a]]
insertAt x y z
               | z == (length y) = insertion
               | otherwise = insertion ++ (insertAt x y (z + 1))
               where insertion = [(take z y) ++ [x] ++ (drop z y)]
