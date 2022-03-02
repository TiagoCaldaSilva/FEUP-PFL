mindiv :: Int -> Int
mindiv x
        | length divs == 0 = x
        | otherwise = head divs
        where divs = [ xs | xs<-[2.. round (sqrt (fromIntegral x))], (x `mod` xs) == 0]

primo :: Int -> Bool
primo x = x > 1 && mindiv x == x
