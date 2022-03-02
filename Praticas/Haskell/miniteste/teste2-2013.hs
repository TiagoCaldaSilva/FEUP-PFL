-- 1.a
nodeups x = [y | (y, z)<-zip x (tail x), y /= z] ++ [last x]

-- 1.b
nodeups :: Eq a => [a] -> [a]

-- 2
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = (Node x Vazia Vazia)
inserir x (Node y l r)
        | x == y = (Node x l r)
        | x < y = (Node y (inserir x l) r)
        | otherwise = (Node y l (inserir x r))

-- 3
data Box = Text String -- texto simples
        | Horiz Box Box -- justaposição horizontal
        | Vert Box Box -- justaposição vertical

altura, largura :: Box -> Int
altura (Text _) = 1
altura (Horiz b1 b2) = max (altura b1) (altura b2)
altura (Vert b1 b2) = 1 + max (altura b1) (altura b2)
largura (Text x) = length x
largura (Horiz b1 b2) = (largura b1) + (largura b2)
largura (Vert b1 b2) = max (largura b1) (largura b2)

-- testar (Horiz (Vert (Vert (Text "A") (Text "B")) (Horiz (Text "A") (Text "B"))) (Text "CCC"))
