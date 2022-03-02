last_element1 :: [a] -> a
last_element1 list = head(drop(length list - 1) list)

last_element2 :: [a] -> a
last_element2 list = head(reverse list)

remove_last :: [a] -> [a]
remove_last list = reverse (tail (reverse list))
--remove_last list = take( length list - 1) list
