import Data.Char

forte :: String -> Bool
forte x = (length x >= 8) && lower && upper && digit
        where lower = or [isLower xi | xi <- x]
              upper = or [isUpper xi | xi<-x]
              digit = or [isDigit xi | xi<-x]
