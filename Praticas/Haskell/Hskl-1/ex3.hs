metades :: [a] -> ([a], [a])
metades list = (take size list, drop size list)
              where size = (div (length list)  2)
-- metades list = if impar then (take list_length_i list, drop list_length_i list)
--                else (take list_length_p list, drop list_length_p list)
--                 where impar = mod (length list) 2 /= 0
--                       list_length_p = (div (length list) 2)
--                       list_length_i = (div (length list) 2) + 1
