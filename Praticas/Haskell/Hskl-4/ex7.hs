import Arvore

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + (sumArv esq) + (sumArv dir)
