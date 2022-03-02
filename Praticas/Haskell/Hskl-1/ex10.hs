classifica :: Float -> Float -> String
classifica peso altura
              | imc < 18.5 = "baixo peso"
              | 18.5 <= imc && imc < 25 = "peso normal"
              | 25 <= imc && imc < 30 = "excesso peso"
              | 30 <= imc = "obesidade"
              where imc = peso / (altura ^ 2)
