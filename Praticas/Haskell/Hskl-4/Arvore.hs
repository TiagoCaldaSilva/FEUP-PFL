module Arvore where
import Data.List

data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

getArv :: Num a => Arv a
getArv = (No 11 (No 3 (No 2 Vazia Vazia) (No 5 Vazia Vazia)) (No 19 (No 13 Vazia Vazia) (No 23 Vazia Vazia)))

listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
                    | x == y = No y esq dir            -- já ocorre; não insere
                    | x < y  = No y (inserir x esq) dir -- insere à esquerda
                    | x > y  = No y esq (inserir x dir) -- insere à direita

construir :: Ord a => [a] -> Arv a
construir xs = foldr inserir Vazia xs

-- Construir uma árvore equilibrada
-- pré-condição: a lista de valores deve estar
-- por ordem crescente
partBin :: [a] -> Arv a
partBin [] = Vazia
partBin xs = No x (partBin y) (partBin z)
            where n = length xs `div` 2 -- ponto médio
                  y = take n xs -- partir a lista
                  (x:z) = drop n xs
