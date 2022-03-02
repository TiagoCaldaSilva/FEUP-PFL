import Data.Char

cifraChave :: String -> String -> String
cifraChave s c = map f (zipWith (+) word offset)
               where offset = cycle [ord(x)-65 | x<-c]
                     word = [ord(x) | x<-s]
                     f x = chr (((x `mod` 65) `mod` 26) + 65)
