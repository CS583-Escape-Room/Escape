module Escape_main where

import Escape_func
import Escape_type
import Escape_house
import Data.List
import Data.List.Split
import Control.Monad.State


main :: IO()
main = do
    putStrLn ""
    putStrLn "Well come to play the Escape game. !!!"
    putStrLn "You are in the Home page."
    putStrLn "You can input the 'start' to play the game, or 'exit' to close the game."
    putStrLn "Also, you can input 'help' to see the commend."
    putStr "> "
    line <- getLine
    if      line == "exit" then return()
    else if line == "help" then help "main" player1 house1
    else if line == "start" then run_code player1 house1
    else do
        putStrLn ("wrong input: '" ++ line ++ "' Please try again.")
        main

help :: String -> Player -> House -> IO()
help = \x a b -> do
    putStrLn ""
    putStrLn "instructions                                  | Describing instructions"
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    if x == "main" then
                    putStrLn "start                                         | you can use this instruction to start the game."
    else putStr ""
    putStrLn "exit                                          | you can use this instruction to exit the game."
    putStrLn "search 'object's name'                        | you can use this instruction to know what item in the object and get it, or check the door."
    -- putStrLn "open 'door's id'                              | you can use this instruction to open the door. (not finish)"
    putStrLn "search room                                   | you can use this instruction to search all object in your current room."
    putStrLn "check bag                                     | you can use this instruction to check the bag items."
    putStrLn "move 'room's name'                            | you can use this instruction to move the player to the room which you input and the room must can accpect."
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn ""
    if x == "main" then main else run_code a b



cmd :: Cmd -> Player -> House -> IO()
cmd (Help s)                    p h = help s p h
cmd Exit                        p h = main
cmd (SearchRoom rm)             p h = do
                                    if not (null (get_objects rm)) then
                                        putStrLn ("The objects in room: " ++ intercalate ", " (map get_name (get_objects rm)))
                                    else putStrLn "No objects in this room. "
                                    run_code p h
cmd (SearchObj objname obj)     p h = do
                                    let items = get_items obj
                                    if not (get_status obj) then do
                                        case get_lock obj of
                                            (Password pw) -> do 
                                                putStrLn "This is password."
                                                run_code p h
                                            (Key i) -> do
                                                if any (== i) (get_bag_item p) then do
                                                    let np = add_item_in_bag p items
                                                    let nh = remove_item_in_obj (get_location p) h obj
                                                    putStrLn ("You success open the " ++ objname ++ ". ")
                                                    putStrLn (get_unlock_info obj)
                                                    putStrLn ("You got items : " ++ intercalate ", " (map get_name items))
                                                    run_code np nh
                                                else do
                                                    putStrLn (objname ++ " is lock, you need a key.")
                                                    putStrLn (get_lock_info obj)
                                                    run_code p h
                                    else do
                                        if null items then do
                                            let nh = remove_item_in_obj (get_location p) h obj
                                            putStrLn (get_unlock_info obj)
                                            run_code p nh
                                        else do
                                            let np = add_item_in_bag p items
                                            let nh = remove_item_in_obj (get_location p) h obj
                                            putStrLn (get_unlock_info obj)
                                            putStrLn ("You got items : " ++ intercalate ", " (map get_name items))
                                            run_code np nh
cmd (SearchDoor objname obj)    p h =   if not (get_status obj) then do
                                            case get_lock obj of
                                                (Password pw) -> do 
                                                    putStrLn "This is password."
                                                    run_code p h
                                                (Key i) -> do
                                                    if any (==i) (get_bag_item p) then do
                                                        let nh = unlock_door (get_location p) h obj
                                                        putStrLn "Good job, the door is unlock."
                                                        putStrLn (get_unlock_info obj)
                                                        putStrLn ("You can input 'move " ++ get_connect obj ++ "' to move to the " ++ get_connect obj ++ " room.")
                                                        run_code p nh
                                                    else do
                                                        putStrLn "Sorry this door can not open, you need a key."
                                                        putStrLn (get_lock_info obj)
                                                        run_code p h
                                        else do
                                            putStrLn "The door is unlock."
                                            putStrLn (get_unlock_info obj)
                                            putStrLn ("If you want to move to the " ++ get_connect obj ++ " room, you can input 'move " ++ get_connect obj ++ "'.")
                                            run_code p h
cmd (Search rm objname)         p h = do
                                    let objs = get_objects rm
                                    if any ((==objname) . get_name) objs then do
                                        let obj = get_obj_by_name objs objname
                                        if get_type obj == "obj" then cmd (SearchObj objname obj) p h else cmd (SearchDoor objname obj) p h
                                    else do
                                        putStrLn ("This room does not have '" ++ objname ++ "' object.")
                                        run_code p h
cmd Bag                         p h = do
                                    let i = get_bag_item p
                                    putStrLn ("Your bag have " ++ show (length i) ++ " items" ++ show_bag_item i 1)
                                    run_code p h
cmd (Mov rm roomname)           p h = do
                                    if get_name rm == roomname then do
                                        putStrLn ("Your are in " ++ roomname ++ " now.")
                                        run_code p h
                                    else do
                                        let objs = get_objects rm
                                        let doors = get_objects_by_type "door" objs
                                        if any ((==roomname) . get_connect) doors then do
                                            let door = get_obj_by_connect roomname doors
                                            if get_status door then do
                                                let nrm = get_room_by_name roomname h
                                                let np = Player {player_location=get_id nrm, player_bag=get_bag_item p}
                                                run_code np h
                                            else do
                                                putStrLn ("Sorry, you can not move to " ++ roomname ++ " room.")
                                                putStrLn ("You need to find the key to open the '" ++ get_name door ++ "' door.")
                                                run_code p h
                                        else do
                                            putStrLn ("No door can let you move to " ++ roomname ++ ".")
                                            run_code p h
cmd (Other c)                   p h = do
                                    putStrLn ("wrong input: '" ++ c ++ "' Please try again.")
                                    run_code p h

checkWin :: String -> Bool
checkWin roomname = roomname == "exit"

run_code :: Player -> House -> IO()
run_code player house = do
        if checkWin (get_name (get_player_room player house)) then exit
        else do
            putStrLn ""
            putStrLn ("Now you are in the " ++ (get_name (get_player_room player house)) ++ ".")
            putStrLn "What do you want to do? (Hint: if you forget the command you can input 'help')"
            putStr "> "
            line <- getLine
            let line_list = (splitOn " " line)
            let name = (intercalate " " (tail line_list))
            let cmd_length = length line_list
            let rm = get_player_room player house
            if      line == "help"                                  then cmd (Help "run_code") player house
            else if line == "exit"                                  then cmd Exit player house
            else if line == "search room"                           then cmd (SearchRoom rm) player house
            else if line == "check bag"                             then cmd Bag player house
            else if cmd_length > 1 && head line_list == "search"    then cmd (Search rm name) player house
            else if cmd_length > 1 && head line_list == "move"      then cmd (Mov rm name) player house
            else cmd (Other line) player house

exit :: IO()
exit = do
        putStrLn ""
        putStrLn "Congratulation!!! You escape this dangerous room."
        putStrLn "If you want to leave the game, please input the exit."
        putStr "> "
        line <- getLine
        if line == "exit" then main
        else exit
