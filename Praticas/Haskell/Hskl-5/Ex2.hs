module Ex2 where
import Stack

calc:: Stack Float -> String -> Stack Float
calc stk (x:xs)
            | x == '+' = push (lastLastElement + lastElement) (pop (pop stk))
            | x == '-' = push (lastLastElement - lastElement) (pop (pop stk))
            | x == '*' = push (lastLastElement * lastElement) (pop (pop stk))
            | otherwise = push (read [x]::Float) stk
            where lastLastElement = top (pop stk)
                  lastElement = top stk

calcular:: String -> Float
calcular x = top(foldl (\x y -> calc x y) empty aux)
          where aux = words x

main :: IO()
main = do
      x <- getLine
      putStr (show (calcular x) ++ "\n")
