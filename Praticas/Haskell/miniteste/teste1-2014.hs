-- 1.a)
myInsert x xs = takeWhile (<x) xs ++ [x] ++ dropWhile (<x) xs

-- 1.b)
myInsert :: Ord a => a -> [a] -> [a]

-- 2
data Arv a = Vazia
            | No a (Arv a) (Arv a)

tamanho :: Arv a -> Int
tamanho Vazia = 0
tamanho (No x esq dir) = 1 + (tamanho esq) + (tamanho dir)

altura :: Arv a -> Int
altura Vazia = 0
altura (No x esq dir) = 1 + max (altura esq) (altura dir)

--testar (No 4 (No 3 (No 1 Vazia Vazia) (No 2 Vazia Vazia)) (No 5 Vazia Vazia))
