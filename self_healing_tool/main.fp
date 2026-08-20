-- Self-Healing Tool (FP)
-- This module provides functional utilities for self-healing operations
-- using pattern matching and immutable data structures.

module self_healing

import Prelude
import Data.List
import Data.Maybe

-- | Safe division function with edge case handling
safeDivide :: Double -> Double -> Maybe Double
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

-- | Safe list access with edge case handling
safeGet :: Int -> [a] -> Maybe a
safeGet index list
  | index < 0 || index >= length list = Nothing
  | otherwise = Just (list !! index)

-- | Retry operation with exponential backoff simulation
-- | In a real system, this would include actual time-based delays
retryOperation :: (a -> Either Error b) -> Int -> a -> b
retryOperation operation maxRetries input =
  let attempt n
        | n < 0 = defaultResult
        | otherwise =
            case operation input of
              Left _ -> attempt (n - 1)
              Right result -> result
  in attempt maxRetries

-- | Safe transformation with fallback
safeTransform :: (a -> b) -> a -> b -> b
safeTransform _ _ fallback = fallback

-- | Main self-healing process
-- | Takes a list of operations and applies them with error handling
selfHealProcess :: [(String, Double -> Double)] -> [Double] -> [Maybe Double]
selfHealProcess operations inputs =
  map (\input ->
    let results = map (\(_, op) -> op input) operations
    in case filter isJust results of
         [] -> Nothing
         (Just best:_) -> Just best
  ) inputs

-- | Error type for self-healing operations
data Error = 
  | DivisionByZero
  | IndexOutOfBounds
  | InvalidInput
  | NetworkFailure
  | Timeout
  | UnknownError String
  deriving (Show, Eq)

-- | Safe parse function for edge cases
safeParse :: String -> Maybe Int
safeParse "" = Nothing
safeParse str =
  case reads str of
    [(n, "")] -> Just n
    _ -> Nothing

-- | Compose safe functions with error handling
composeSafe :: (a -> Maybe b) -> (b -> Maybe c) -> a -> Maybe c
composeSafe f g x =
  case f x of
    Nothing -> Nothing
    Just y -> g y

main :: IO ()
main = do
  -- Example usage demonstrating self-healing capabilities
  putStrLn "Self-Healing Tool (FP) initialized"
  putStrLn "Safe division (10 / 0): " ++ show (safeDivide 10 0)
  putStrLn "Safe division (10 / 2): " ++ show (safeDivide 10 2)
  putStrLn "Safe list access [1,2,3] at index 1: " ++ show (safeGet 1 [1,2,3])
  putStrLn "Safe list access [1,2,3] at index 5: " ++ show (safeGet 5 [1,2,3])
  putStrLn "Safe parse \"42\": " ++ show (safeParse "42")
  putStrLn "Safe parse \"\": " ++ show (safeParse "")
  putStrLn "\nSelf-healing capabilities demonstrated successfully."
