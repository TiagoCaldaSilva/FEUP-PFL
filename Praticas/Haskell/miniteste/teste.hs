dobro x = x * 2

quadruploEsoma x y = 4 * x + y

soma :: Int -> Int -> Int
soma =  (+)

incr :: Int -> Int
incr = soma 1

concat :: [a] -> [a] -> [a]
concat = (++)

mytry :: Bool -> Bool -> Bool
mytry True x = x
mytry False _ = False

quad :: [Int] -> [Int]
quad x = map (^2) x

permutac :: [Int] -> [[Int]]
permutac a = [[x, y, z] | x<-a, y<-a, z<-a,x /= y && x /= z && y /= z]

myconcat :: [[a]] -> [a]
myconcat x = [v | l<-x, v<-l]

testarInput :: IO String
testarInput = do x <- getChar
                 if x == '\n' then
                   return []
                 else do xs <- testarInput
                         return (x:xs)


boasVindas :: IO ()
boasVindas = do putStr "Como te chamas? "
                x <- getLine
                putStr ("Bem Vindo " ++ x ++ "!!\n")

jogoAux :: Int -> Int -> IO()
jogoAux num t = do putStr "Tentativa? "
                   tentativaStr <- getLine
                   let tentativa = read tentativaStr
                   if tentativa < num
                   then putStr "Demasiado baixo!\n" >> jogoAux num (t+1)
                   else if tentativa > num
                   then putStr "Demasiado alto!\n" >> jogoAux num (t+1)
                   else putStr ("Acertou em " ++ (show t) ++ " tentativas!\n")

jogo :: IO()
jogo = jogoAux 523 1


maisUmTeste :: IO()
maisUmTeste = putStr "Hello, what's your name? " >> getLine >>= \x->putStrLn ("Hello " ++ x )
