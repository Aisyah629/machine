module Main where

import Data.List

-- | A type-safe data transformation utility

-- | Define a generic DataPoint type
newtype DataPoint a = DataPoint a deriving (Show, Eq)

-- | Function to transform a list of data points
transformDataPoints :: (a -> b) -> [DataPoint a] -> [DataPoint b]
transformDataPoints f = map (DataPoint . f)

-- | Filter data points based on a predicate
filterDataPoints :: (a -> Bool) -> [DataPoint a] -> [DataPoint a]
filterDataPoints p = filter (p . fromJust . getVal)
  where getVal (DataPoint x) = Just x

-- | Sum all values in a list of numeric data points
sumDataPoints :: (Num a) => [DataPoint a] -> a
sumDataPoints = sum . map (fromJust . getVal)
  where getVal (DataPoint x) = Just x

-- | Main function to demonstrate usage
main :: IO ()
main = do
    let numbers = map DataPoint [1, 2, 3, 4, 5]
    let squares = transformDataPoints (^2) numbers
    let evenNumbers = filterDataPoints (even . fromJust . getVal) numbers
    
    putStrLn "Original Numbers:"
    print numbers
    
    putStrLn "Squared Numbers:"
    print squares
    
    putStrLn "Even Numbers:"
    print evenNumbers
    
    putStrLn "Sum of Original Numbers:"
    print (sumDataPoints numbers)
