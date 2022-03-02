import Data.Char

cifrar :: Int -> String -> String
cifrar k s
           | k > 0 = [ fpos a | a<- s]
           | otherwise = [ fneg a | a<- s]
           where fpos x = if (x == ' ') then x else offsetPos x
                 offsetPos x = chr((((ord(x) + k) `mod` n) `mod` 26) + n)
                 fneg x = if (x == ' ') then x else offsetNeg x
                 offsetNeg x = chr(((((ord(x) + k + 26) `mod` n) - 26) `mod` 26) + n)
                 n = if ( ord(head s) >= 97) then 97 else 65
