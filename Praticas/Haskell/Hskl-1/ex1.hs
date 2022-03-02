testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = if (a + b <= c) || (b + c <= a) || (a + c <= b) then False else True
