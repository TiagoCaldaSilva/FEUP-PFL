fromBits :: [Int] -> Int
fromBits lista = sum ([xi * (2 ^ i) | (xi, i)<-zip lista (reverse[0.. (length lista - 1)])])
