addPoly :: [Int] -> [Int] -> [Int]
addPoly y x
          | length y > length x = zipWith (+) y (x ++ [ 0 | i<-[1..((length y) - (length x))]])
          | otherwise = zipWith (+) x (y ++ [ 0 | i<-[1..((length x) - (length y))]])

addPoly' :: [Int] -> [Int] -> [Int]
addPoly' [] [] = []
addPoly' (y:ys) [] = [y] ++ addPoly ys []
addPoly' [] (x:xs) = [x] ++ addPoly [] xs
addPoly' (y:ys) (x:xs) = [y + x] ++ addPoly ys xs

multPoly :: [Int] -> [Int] -> [Int]
multPoly x y =  [sum [fst xs | xs<-[ nss | ns <- mult, nss<-ns], snd xs == i] | i<-[0..(length x + length y) - 2]]
             where listX = zip x [0..(length x - 1)]
                   listY = zip y [0..(length y - 1)]
                   mult = [[((fst xi) * (fst yi), (snd xi) + (snd yi)) | yi <- listY] | xi <- listX]
