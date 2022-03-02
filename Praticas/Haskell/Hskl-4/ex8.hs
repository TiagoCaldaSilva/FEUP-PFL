import Arvore

listarDec :: Arv a -> [a]
listarDec Vazia = []
listarDec (No x esq dir) = listarDec dir ++ [x] ++ listarDec esq
