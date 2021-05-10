module Escape_main where

import Escape_func
a = 1
main = do
    putStrLn ("Well come to play Escape game." ++ show a)
    line <- getLine
    if line == "return"
        then return()
        else do
            main