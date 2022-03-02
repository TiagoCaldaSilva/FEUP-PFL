import Arvore

calcAltura :: Arv a -> Int
calcAltura Vazia = 0
calcAltura (No x esq dir) = 1 + max (calcAltura esq) (calcAltura dir)

-- Para testar:
-- calcAltura (construir [1..100]) -> 100
-- calcAltura (partBin [1..100]) -> 7
