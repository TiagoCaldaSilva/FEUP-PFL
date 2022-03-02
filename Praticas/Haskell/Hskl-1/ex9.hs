classifica :: Int -> String
-- classifica x = if x <= 9 then "reprovado"
--                else if 10 <= x && x <= 12 then "suficiente"
--                else if 13 <= x && x <= 15 then "bom"
--                else if 16 <= x && x <= 19 then "muito bom"
--                else if 19 <= x && x <= 20 then "muito bom com distincao"
--                else "invalid number"
classifica x
        | x <= 9 = "reprovado"
        | 10 <= x && x <= 12 = "suficiente"
        | 13 <= x && x <= 15 = "bom"
        | 16 <= x && x <= 19 = "muito bom"
        | 19 <= x && x <= 20 = "muito bom com distincao"
        | otherwise = "invalid number"
