my_mdc :: Int -> Int -> Int
my_mdc a b = fst (until (\(a, b) -> b == 0) (\(a, b) -> (b, (a `mod` b))) (a, b))
