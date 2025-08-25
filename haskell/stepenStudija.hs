module Lib where

import Data.List as List (elemIndex, sortBy)

data StepenStudija = OsnovneStudije 
                    | MasterStudije 
                    | DoktorskeStudije
                    deriving (Show, Eq)

data KratkiStepenStudija = Kratko StepenStudija

instance Show KratkiStepenStudija where 
    show (Kratko x) 
        | x == OsnovneStudije   = "BSc"
        | x == MasterStudije    = "MSc"
        | x == DoktorskeStudije = "PhD"

instance Eq KratkiStepenStudija where
    (Kratko s1) == (Kratko s2) = s1 == s2

data Student = MkStudent {
    indeks :: String
    , ime :: String
    , prezime :: String
    , stepen :: StepenStudija
    }

formatirajStudenta :: Student -> String
formatirajStudenta s = 
    let index = indeks s
        ip = (ime s) ++ " " ++ (prezime s)
        ss = show $ Kratko $ stepen s
    in index ++ " : " ++ ip ++ " : " ++ ss 

instance Show Student where
    show = formatirajStudenta

instance Eq Student where
    s1 == s2 = indeks s1 == indeks s2

type Rezultat = (Student, Maybe Int)
rezultati :: [Student] -> [Rezultat]
rezultati studenti = map (\s -> (s, Nothing)) studenti

poeni :: Student -> [Rezultat] -> Either String (Maybe Int) --Ili mi vracas studentove poene ili mi vracas studenta koji nije na listi
poeni s rezultati =
    case mi of Nothing  -> Left $ (indeks s) ++ " nije u listi" --Na celu levu stranu samo ispises indeks nije u listi
               (Just i) -> Right $ snd $ rezultati !! i --na celu desnu stranu vadis rezultat na poziciji i, a zatim ispisujes bodove
    where mi = List.elemIndex s $ map fst rezultati --preko mape uzimamo svaki prvi element iz rezultata -> lista Studenata
                                                    --Zatim na sve to primenimo List.elemIndex i trazimo tog studenta

ponisti :: Student -> [Rezultat] -> [Rezultat]
ponisti s rezultati = foldl azuriraj [] rezultati
    where azuriraj acc rez = if fst rez == s then acc ++ [(s, Nothing)] 
                                             else acc ++ [rez]

studije :: StepenStudija -> [Rezultat] -> [Rezultat]
studije ss rezultati = filter(\t -> stepen (fst t) == ss) rezultati
--Moze i studije ss rezultati = filter(\(s, _) -> stepen s == ss)

polozeni :: [Rezultat] -> [Rezultat]
polozeni rez = filter(\(_, t) -> (izvuciRez t) > 50) rez
    where izvuciRez Nothing = 0
          izvuciRez (Just a) = a

upisi :: Student -> Int -> [Rezultat] -> [Rezultat]
upisi s p rez = if elem s studenti
                then foldr azuriraj [] rez
                else (s, Just p) : rez
    where studenti = map fst rez
          azuriraj rezu acc = if fst rezu == s then (s, Just p) : acc
                                             else rezu : acc


najboljih :: Int -> [Rezultat] -> [Int] 
najboljih n rezultati = take n
                    $ sortBy (flip compare) --Opadajuci poredak se radi sa flip complare
                    $ map (\(Just x) -> x)
                    $ filter (\m -> m /= Nothing)
                    $ map snd
                    $ rezultati

