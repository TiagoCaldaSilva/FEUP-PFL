import Ex12 (intercalar)

perms :: [a] -> [[a]]
perms [] = [[]]
perms (x:xs) = concat [intercalar x i | i<-y]
              where y = perms xs
