module Main where
import Ex2

main :: IO()
main = do
     x <- getLine
     print (calcular x)
