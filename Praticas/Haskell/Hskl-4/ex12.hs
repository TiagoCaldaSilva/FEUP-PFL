import Arvore

maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

removerEsq :: Ord a => a -> Arv a -> Arv a
removerEsq x Vazia = Vazia -- não ocorre
removerEsq x (No y Vazia dir) -- um descendente
        | x==y = dir
removerEsq x (No y esq Vazia) -- um descendente
        | x==y = esq
removerEsq x (No y esq dir) -- dois descendentes
        | x<y = No y (removerEsq x esq) dir
        | x>y = No y esq (removerEsq x dir)
        | x==y = let z = maisEsq dir
                 in No z esq (removerEsq z dir)

maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

removerDir :: Ord a => a -> Arv a -> Arv a
removerDir x Vazia = Vazia -- não ocorre
removerDir x (No y Vazia dir) -- um descendente
        | x==y = dir
removerDir x (No y esq Vazia) -- um descendente
        | x==y = esq
removerDir x (No y esq dir) -- dois descendentes
        | x<y = No y (removerDir x esq) dir
        | x>y = No y esq (removerDir x dir)
        | x==y = let z = maisDir esq
                 in No z (removerDir z esq) dir
