--Napisati biblioteku funkcija koja će podržati implementacije raznih kartaških igara. Potrebno je modelirati kartu, skup
--izvučenih karata (u daljem tekstu ruka), kao i funkcije za rad sa definisanim modelom. Svaka karta se sastoji od znaka (herc,
--karo, pik, tref) vrednosti (od 2 do 10 za karte bez slike, dok žandar ima vrednost 12, kraljica 13, kralj 14 a kec 15).
--Karte se porede po njihovim vrednostima, a u slučaju da su vrednosti iste, onda se posmatraju znakovi po sledećem poretku
--(od najmanjeg ka najvećem): herc, karo, pik, tref. Na primer, trojka tref je manja od petice herc, ali je trojka herc manja od
--trojke tref.

module Lib where

import Data.List as List (elemIndex, sortBy)

data Znak = Herc | Pik | Karo | Tref
    deriving (Eq, Show, Enum, Bounded)

data Vrednost = Broj Int
    | Zandar 
    | Kraljica 
    | Kralj
    | Kec 
    deriving(Eq, Show)

data Karta = MkKarta {
    vrednost :: Vrednost,
    znak :: Znak
} deriving (Eq, Show)

type Ruka = [Karta]

vrednostInt :: Vrednost -> Int
vrednostInt (Broj n)    = n
vrednostInt Zandar      = 12
vrednostInt Kraljica    = 13
vrednostInt Kralj       = 14
vrednostInt Kec         = 15

instance Ord Vrednost where
    compare v1 v2 = compare (vrednostInt v1) (vrednostInt v2)

instance Ord Znak where
    compare Herc Karo   = LT
    compare Herc Pik    = LT
    compare Herc Tref   = LT
    compare Pik Karo    = LT
    compare Pik Tref    = LT
    compare Karo Tref   = LT
    compare a b
        | a == b    = EQ 
        | otherwise = GT

instance Ord Karta where
  compare (MkKarta v1 z1) (MkKarta v2 z2) =
    case compare v1 v2 of
      EQ -> compare z1 z2
      ord -> ord

--a) dodaj koja u trenutno sortiranu ruku dodaje novu kartu tako da je soritrani poredak odrzan i vraca potencijalno modifikovanu ruku

dodaj :: [(Int, Char)] -> (Int, Char) -> [(Int, Char)]
dodaj [] x = [x]
dodaj (y:ys) x
            | x <= y = x : y : ys
            | otherwise = y : dodaj ys x

--b) ukloni koja uklanja kartu iz ruke, ukoliko ona ne postoji ne raditi nista
ukloni :: [(Int, Char)] -> (Int, Char) -> [(Int, Char)]
ukloni (y : ys) x 
            | y == x = ys
            | otherwise = y : ukloni ys x

--c) uporedi ruka1 ruka2 koja poredi dve ruke i vraca poredak LT ako je prva ruka u leksikografksom poretku pre druge, GT ako je prva
--ruka u leksi poretku posle druge ili EQ ukoliko su jednake leksikografksi
uporedi :: [(String, Int)] -> [(String, Int)] -> Ordering
uporedi ruka1 ruka2 = compare ruka1 ruka2

--izlistaj znak ruka koja vraca sve karte iz ruke sa istim znakom znak
izlistaj :: Znak -> Ruka -> [Karta]
izlistaj z ruka = [x | x <- ruka, znak x == z]

--najjaca koja vraca najjacu kartu iz ruke
najjaca :: Ruka -> Karta
najjaca ruka = maximum ruka





