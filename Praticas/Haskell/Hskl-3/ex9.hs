scanl' :: (b -> a -> b) -> b -> [a] -> [b]
scanl' f z [] = [z]
scanl' f z (x:xs) = z:(scanl' f (f z x) xs)
