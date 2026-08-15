! Oriel Language Implementation
! Main execution unit
module Main where

import Prelude

! Define the entry point
main :: IO ()
main = do
    putStrLn "Hello from Oriel!"
    putStrLn "Executing Oriel tool logic."
    runOrielProgram
