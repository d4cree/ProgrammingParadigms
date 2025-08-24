module Lib where

--Tacka
type Tacka = (Float, Float)

tacka :: Float -> Float -> Tacka
tacka x y = (x, y)

--Koordinatni pocetak
o :: Tacka
o = (0.0, 0.0)

--Putanja
type Putanja = [Tacka]
putanja :: [Tacka] -> Putanja
putanja = id

--Duzina putanje
duzinaPutanje :: Putanja -> Int
duzinaPutanje p = length $ p --ili duzinaPutanje = length

--Rastojanje
rastojanje :: Tacka -> Tacka -> Float
rastojanje x y = sqrt $ (fst y - fst x)^2 + (snd y - snd x)
--rastojanje (x1 , y1) (x2 , y2) = sqrt $ (x1 -x2)^2 + (y1 -y2)^2 --moze i ovako

--U krugu?
uKrugu :: Float -> [Tacka] -> [Tacka]
uKrugu r xs = [x | x<-xs, rastojanje x o < r]

--Transliraj tacku
transliraj :: Tacka -> Float -> Float -> Tacka
transliraj (x, y) dx dy = (x + dx, y + dy) --transliraj t dx dy = (fst t + dx, snd t + dy) Moze i ovako ali je malo rizicnije ukoliko promene definiciju tacke

--Transliraj putanju
translirajPutanju :: Putanja -> Float -> Float -> Putanja
translirajPutanju p x y = map (\t -> transliraj t x y) p
--map f xs -> primeni funkciju f na svaki element iz liste xs, a zatim vrati azuriranu listu

--Nadovezivanje
nadovezi :: Tacka -> Putanja -> Putanja
nadovezi t p = p ++ [t]
--Moze i preko reverse funkcije
--nadovezi t p = reverse $ t : (reverse putanja) 
--U principu, obrnu putanju, nadovezi t na to i ponovo obrni celu putanju

--Spoji putanje
spojiPutanja :: Putanja -> Putanja -> Putanja
spojiPutanja p1 p2 = p1 ++ p2
--moze i spojiPutanja == (++)

--Centroid
centroid :: [Tacka] -> Tacka
centroid ts = tacka prosekX prosekY
    where prosekX = prosek $ map fst ts
          prosekY = prosek $ map snd ts
          prosek lst = (sum lst) / ( fromIntegral $ length lst)

--Kvadrant Tacke
kvadrant :: Tacka -> Int 
kvadrant (x, y) 
            | x < 0 && y > 0 = 1
            | x > 0 && y > 0 = 2
            | x > 0 && y < 0 = 3
            | x < 0 && y < 0 = 4   
            | otherwise = 0

--Kvadrant Putanje
kvadrantPutanje :: Putanja -> Int
kvadrantPutanje p = if istiKvadranti then head kvadranti else 0
    where kvadranti     = map kvadrant p  --Napravis listu kvadranta
          istiKvadranti = all (== head kvadranti) (tail kvadranti) --provera da li su svi u listi jednaki!

--Tacke u kvadrantu
tackeUKvad :: Int -> [Tacka] -> [Tacka]
tackeUKvad kv xs = [x | x<-xs, kvadrant x == kv]
--Moze i ovako 
--tackeUKvadrantu :: Int -> [Tacka] -> [Tacka]
--tackeUKvadrantu k lst = filter (\t -> kvadrantTacke t == k) lst - filtriras tj vadis samo one tacke za koje ti vazi da je kvadrantTacke t == k

--Tacke van
tackeVanKvad :: Int -> [Tacka] -> [Tacka]
tackeVanKvad kv xs = [x | x <- xs, kvadrant x /= kv]
--Moze i ovako
--tackeVanKvadranta k = filter (\t -> (not . (==k)) ( kvadrantTacke t)) -- filtriras sve tacke tako da kvadrantTacke t nije jednako ==k

maksimumi :: [Tacka] -> (Float, Float)
maksimumi lst = (maksimum $ map fst lst, maksimum $ map snd lst)
    where maksimum lst = foldl (\acc x -> if acc > x then acc else x) (head lst) (tail lst) -- funckija -> akumulator -> lista
    --Moze umesto (\acc x -> if acc > x then acc else x) samo max
    --Moze i takodje umesto maksimum funkcije da koristimo unapred definisanu maximum funkciju 
    --Moze i foldl1 max (tail lst) - foldl1 automatski uzima prvi element liste kao akumulator



