binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..n-k])

binom' :: Integer -> Integer -> Integer
binom' n k
          | (n <= 0) || (k < 0) = error "Error"
          | (k == 0) || (n == k) = 1
          | (k == 1) || (k == (n-1)) = n
          | otherwise = (binom' (n-1) (k-1)) + (binom' (n-1) k)

pascal :: [[Int]]
pascal = [[fromInteger(binom n k) | k<-[0..n]] | n<-[1..]]

-- pascal' :: [[Int]]
-- pascal' = [[fromInteger(binom' n k) | k<-[0..n]] | n<-[1..]]

pascal' :: [[Int]]
pascal' = [ [ if (k==0 || n==k) then 1
              else get (n-1) (k-1) + get (n-1) k | k<-[0..n]] | n<-[0..]]
        where get x y = (!!) ((!!) pascal' x) y
