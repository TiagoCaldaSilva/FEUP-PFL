safetail_p :: [a] -> [a]
safetail_p [] = []
safetail_p (_: a) = a

safetail_g :: [a] -> [a]
safetail_g x
        | length x == 0 = []
        | otherwise = tail x

safetail_c :: [a] -> [a]
safetail_c x = if length x == 0 then [] else tail x
