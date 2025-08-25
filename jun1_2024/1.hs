module Lib where

import Data.List as List(elemIndex, sortBy)

--a) napraviti funkciju polozili koja na ulazu dobija rezultate ispita u vidu liste neuredjenih parova (ime, poeni) i vraca listu
--imena studentata koji su polozili ispit (imaju vise od 50 poena)

polozili :: [(String, Int)] -> [String]
polozili rez = [x | (x, y)<-rez, y > 50]

--b) najbolji koja na ulazu dobija rezultate ispita u vidu liste uredjenih parova (ime, poeni) i vraca ime studenta koji je imao 
--najveci broj poena na tom ispitu. (Ukoliko ima vise takvih, vratiti poslednjeg)
najbolji :: [(String, Int)] -> String
najbolji rez = fst $ foldl uporedi ("", -1) rez
    where uporedi (x, y) rez 
                            | y > snd rez  = (x, y)
                            | otherwise     = rez

--c) prosek ciji potpis je prosek :: [(String, Int)] -> Float
--koja na ulazu prima rezultate ispita u vidu list uredjenih parova (ime, poeni) i vraca prosecnu ocenu na tom ispitu
promeni :: Int -> Int
promeni x 
    | x > 51 && x < 60  = 6
    | x > 61 && x < 70  = 7
    | x > 71 && x < 80  = 8
    | x > 81 && x < 90  = 9
    | otherwise = 10

prosek :: [(String, Int)] -> Float
prosek rez = izrprosek $ ocena $ (polozeni rez)
    where 
        polozeni rez = [y | (x, y) <- rez, y > 50] --Lista polozenih poena
        ocena rez = map promeni rez --Lista Ocena
        izrprosek rez = fromIntegral (sum rez)/ fromIntegral (length rez) --pretvaramo vrednosti u float preko fromIntegral

--Kreirati tip Student koji se moze konstruisati preko MkStudent i sadrzi dva atributa, ime (String) i poeni (Int), kao i funkcije
--ime i poeni koji omogucavaju pristup poljima ime i poeni. Za kreirani tip instancirati klasu Show (podrazumevano) i klasu Ord
--tako da se studenti porede po broju ostvarenih poena

data Student = MkStudent {
    ime :: String
    , poeni :: Int
    } deriving Show

instance Eq Student where
    s1 == s2 = (poeni s1) == (poeni s2)

instance Ord Student where
    compare s1 s2 = compare (poeni s1) (poeni s2)

--Napravi funkciju rangLista koja sortira listu poena opadajuce

rangLista :: [Student] -> [Student]
rangLista lst = sortBy (flip compare) $ lst

--Implementirati funkciju poeniStudenata koji na ulazu dobija listu studenata i za svakog od njih u slucaju polozenog ispita
--vraca ime i poene, inace ime i praznu vrednost

poeniStudenata :: [Student] -> [(String, Maybe Int)]
poeniStudenata lst = map f lst
    where f s 
            | poeni s > 50 = (ime s, Just (poeni s))
            | otherwise = (ime s, Nothing)

