import Arvore

nivel :: Int -> Arv a -> [a]
nivel n Vazia = []
nivel 0 (No x esq dir) = [x]
nivel n (No x esq dir) = nivel (n-1) esq ++ nivel (n-1) dir
