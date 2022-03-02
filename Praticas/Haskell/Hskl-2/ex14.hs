myNub :: Eq a => [a] -> [a]
myNub [] = []
myNub (x:xs) = x:myNub([y | y <- xs, x /= y])
