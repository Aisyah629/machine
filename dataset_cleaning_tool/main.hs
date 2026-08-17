module Main where

import qualified Data.Map.Strict as M
import Data.List (nub, sortBy, groupBy)
import Data.Char (isSpace, toLower, isDigit, isAlphaNum)
import Text.Regex.TDFA -- Requires: regex-tdfa
import System.Environment (getArgs)
import Text.Parsec
import Text.Parsec.String (Parser)
import Text.Parsec.Error

-- Data Types

type Field = String
type Record = M.Map Field String
type Dataset = [Record]

data CleanError = MissingField Field | InvalidType Field String | DuplicateRecord String

-- 1. Schema Inference and Parsing

parseCSV :: String -> Either String Dataset
parseCSV content = do
  let linesList = lines content
  guard $ not $ null linesList
  let headers = parseHeader (head linesList)
  let records = map (parseRecord headers) (tail linesList)
  case filter (== Left "Error") records of
    [] -> Right $ map fromRight records
    err:_ -> Left "Parsing failed"
  where
    parseHeader :: String -> [Field]
    parseHeader = map trim . splitOn ","
    
    parseRecord :: [Field] -> String -> Either String Record
    parseRecord fields row = do
      let vals = map trim (splitOn "," row)
      if length vals /= length fields
        then Left "Error"
        else Right $ M.fromList (zip fields vals)
        
    splitOn c s = case dropWhile (== c) s of
      [] -> []
      ws -> w : splitOn c (drop 1 ws)
      where (w, rest) = span (/= c) s

-- 2. Cleaning Functions

trim :: String -> String
trim = f . f
  where f = reverse . dropWhile isSpace

cleanWhitespace :: Record -> Record
cleanWhitespace rec = M.map (trim . unwords . words) rec

deduplicate :: Dataset -> Dataset
deduplicate = reverse . map head . groupBy ((==) `on` (M.toList . snd)) . sortBy (compare `on` (M.toList . snd))

-- Simple type inference and validation (Mock)
validateTypes :: Dataset -> Either [CleanError] Dataset
validateTypes ds = Right ds -- Placeholder for complex type validation

-- 3. Main Pipeline

main :: IO ()
main = do
  args <- getArgs
  case args of
    [inputFile] -> do
      content <- readFile inputFile
      case parseCSV content of
        Left err -> putStrLn $ "Error: " ++ err
        Right dataset -> do
          let cleaned = cleanWhitespace dataset
          let unique = deduplicate cleaned
          mapM_ print unique -- Or write to file
    _ -> putStrLn "Usage: dataset_cleaner <input.csv>"
