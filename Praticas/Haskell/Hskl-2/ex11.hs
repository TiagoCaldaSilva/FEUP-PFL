myReplicate :: Int -> a -> [a]
myReplicate n x = [x  | i<-[1..n]]

pontoExc :: [a] -> Int -> a
pontoExc l n = head [ y | (y, i)<-zip l [0..n], i == n]

myConcat :: [[a]] -> [a]
myConcat x = [ n | xi<-x,  n<-xi]
