module Escape_main where

import Escape_func
a = 1
main = do
    putStrLn "Well come to play the Escape game."
    putStrLn "You can input the 'start' to play the game. or 'exit' to close the game"
    line <- getLine
    if line == "exit" then return()
    else if line == "start" then do
                                run_code
                            else
                                do
                                putStrLn ("wong input: '" ++ line ++ "' Please try again.")
                                main

help = do
    putStrLn ""
    putStrLn "instructions            : Describing instructions"
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn "search 'object's name'  : you can use this instruction to know what item in the object and get it."
    putStrLn "open 'door's id'        : you can use this instruction to open the door."
    putStrLn "show_room               : you can use this instruction to show all object in your current room."
    putStrLn "check_bag               : you can use this instruction to check the bag items."
    putStrLn "move 'room's id'        : you can use this instruction to move the player to the id of room which you can accpect."
    putStrLn "move 'room's name'      : you can use this instruction to move the player to the name of room which you can accpect."
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn ""
    run_code

run_code = do
        putStrLn "Now you are in room."
        putStrLn "you can type help to see the commend."
        line <- getLine
        if line == "help" then help
        else if line == "exit" then main
        else do
            run_code