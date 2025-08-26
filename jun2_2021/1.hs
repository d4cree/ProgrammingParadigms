--Funkcija za rad sa niskama. 
--a) najduza lst koja pronalazi najduzu nisku iz liste lst , ako je vise takvih niski, vrati prvu. Pretpostaviti da lista ima barem jedan element

module Lib where

import Data.List as List (elemIndex, sortBy)
import Data.Char (toLower, chr)

najduza :: [String] -> String
najduza = maximum

--b) umanji str koja transformise velika u mala slova, a ostala velika ne dira
umanji :: String -> String
umanji = map toLower

umanji' :: String -> String
umanji' = map umanjiSlovo
    where umanjiSlovo c
            | c >= 'A' && c <= 'Z' = toEnum (fromEnum c + 32)
            | otherwise          = c
--Oba nismo radili, morao sam da izguglam :/

--c) razdvoji sep str koja vraca listu substringova odvojenih sa separatorom
razdvoji :: Char -> String -> [String]
razdvoji _ [] = [""] --kad stignes do kraja rekurzije vrati praznu nisku
razdvoji sep (c:cs) 
    | c == sep      = "" : rest --ako je jednako sep, izbaci sep
    | otherwise     = (c : head rest) : tail rest --inace nalepi karakter na glavu a zatim nastavi sa stringom, pravim tokene
    where rest = 
            razdvoji sep cs

--d) funkcija spoji koja spaja string na kontu separatora
spoji :: String -> [String] -> String
spoji sep (x:xs)
    | length(xs) /= 0   = x ++ sep ++ spoji sep xs
    | otherwise         = x

data Poklapanje = MkPoklapanje {
    kar :: Char
    , poz :: Int
    } deriving Show

--e)poklapanjeShow koji vraca nisku "slovo index_poklapanja"
poklapanjeShow :: Poklapanje -> String
poklapanjeShow p = [kar p] ++ " " ++ show (poz p)

--f) poklapanjeM koje vraca poklapanje u nisci str ukoliko je unutar niske, inace Nothing
poklapanjeM :: Int -> String -> Maybe Poklapanje
poklapanjeM n str 
    | n < 0     = Nothing
    | otherwise = go 0 str
    where 
        go _ [] = Nothing
        go i (x:xs)
            | i == n    = Just (MkPoklapanje x i)
            | otherwise = go (i+1) xs

--g) poklapanjeE koje vraca poklapanje niske na indeksu i u str-u ukoliko je i unutar granica niske
poklapanjeE :: Int -> String -> Either String Poklapanje
poklapanjeE n (x:xs) = case poklapanjeM n (x:xs) of
        Just (MkPoklapanje x n)  -> Right (MkPoklapanje x n)
        Nothing                  -> Left "Index error"


--h) pronadjiM koja ti vraca da li se neko slovo nalazi na toj poziciji u reci, inace Nothing
pronadjiM :: Poklapanje -> String -> Maybe Bool
pronadjiM p str
    | (poz p) < 0       = Nothing
    | otherwise         = go 0 str
    where 
        go _ []         = Nothing
        go i (x:xs)
            | i == poz p    = Just (kar p == x)
            | otherwise     = go (i+1) xs

--i) pronadjiE koja vraca da li se slovo nalazi u toj poziciji, inace ispisuje "Index error"
pronadjiE :: Poklapanje -> String -> Either String Bool
pronadjiE p str = case pronadjiM p str of
        Nothing     -> Left "Index Error"
        Just True   -> Right True
        Just False  -> Right False
