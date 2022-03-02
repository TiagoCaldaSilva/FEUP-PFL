import Stack

parentAux:: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (x:xs) stk
            | not (isEmpty stk) && (x == ')') && ((top stk) == '(') = parentAux xs (pop stk)
            | not (isEmpty stk) && (x == ']') && ((top stk) == '(') = parentAux xs (pop stk)
            | not (isEmpty stk) && (x == '}') && ((top stk) == '{') = parentAux xs (pop stk)
            | (x == '(') || (x == '[') || (x == '{') = parentAux xs (push x stk)
            | otherwise = parentAux xs stk

parent:: String -> Bool
parent x = parentAux x empty
