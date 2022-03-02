palavras :: String -> [String]
palavras [] = []
palavras (' ':xs) = palavras xs
palavras s = [takeWhile (/= ' ') s] ++ palavras ( dropWhile(/= ' ') s)

despalavras :: [String] -> String
despalavras (x:xs) = foldl (\x y -> x ++ " " ++ y) x xs
