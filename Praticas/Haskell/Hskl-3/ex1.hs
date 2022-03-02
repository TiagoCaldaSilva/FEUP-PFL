-- func (\x -> x^2) (\x -> x`mod`2 == 0) [1, 2, 3, 4, 5, 6]
func :: (a -> a) -> (a -> Bool) -> [a] -> [a]
func f p l = map f (filter p l)
