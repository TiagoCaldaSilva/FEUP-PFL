aprox :: Int -> Double
aprox n = 4 * (sum [ formula x  | x <- [0..n] ])
        where formula x = ((-1) ^ x) / fromIntegral (2 * x + 1)

aprox' :: Int -> Double
aprox' k = sqrt( 12 * sum [ formula' x | x <- [0..k] ])
         where formula' x = ((-1) ^ x) / fromIntegral((x + 1) ^ 2)

myNewAprox :: Int -> Double
myNewAprox n = 4* sum[ cima / fromIntegral(2*baixo + 1) | (baixo, cima)<-zip [0..n] aux]
          where aux = cycle [1, -1]

myNewAprox' :: Int -> Double
myNewAprox' n = sqrt ( 12 * somatorio )
              where somatorio = sum sequencia
                    sequencia = [(-1) ^ k / fromIntegral((k + 1) ^ 2) | k<-[0..n]]
