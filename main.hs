module Escape_main where

import Escape_func
import Escape_type
import Data.List
import Data.List.Split

-- | test 
nothing = Item {item_id=0, item_name="", item_info=""}
nokey = Item {item_id=0, item_name="", item_info="This is open."}
rkey1 = Item {item_id=1, item_name="room key", item_info="A key which can open the door."}
dkey1 = Item {item_id=2, item_name="desk key", item_info="A key which can open the desk."}
object1 = Objects {object_id=1, object_name="desk", object_items=[rkey1], object_status=False, object_key=dkey1}
object2 = Objects {object_id=2, object_name="dhair", object_items=[dkey1], object_status=True, object_key=nokey}
object3 = Objects {object_id=3, object_name="book", object_items=[], object_status=True, object_key=nokey}
object4 = Objects {object_id=4, object_name="box", object_items=[], object_status=True, object_key=nokey}
door1 = Door {door_id=1, door_name="exit", door_connect=0, door_status=False, door_key=rkey1}
room1 = Room {room_id=1, room_name="room 1", room_objects=[object1, object2, object3, object4], room_door=[door1]}
ball = Item {item_id=3, item_name="ball", item_info="This ball can do nothing."}
player1 = Player {player_location=1, player_bag=[ball]}
house1 = [room1]


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
        putStrLn ("wong input: '" ++ line ++ "' Please try again.")
        main

help = \x a b -> do
    putStrLn ""
    putStrLn "instructions                                  | Describing instructions"
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    if x == "main" then 
                    putStrLn "start                                         | you can use this instruction to start the game." 
    else putStr ""
    putStrLn "exit                                          | you can use this instruction to exit the game."
    putStrLn "search 'object's name'                        | you can use this instruction to know what item in the object and get it."
    putStrLn "open 'door's id'                              | you can use this instruction to open the door."
    putStrLn "search room                                   | you can use this instruction to search all object in your current room."
    putStrLn "check bag                                     | you can use this instruction to check the bag items."
    putStrLn "move 'room's id'/ move 'room's name'          | you can use this instruction to move the player to the room which you input and the room must can accpect."
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn ""
    if x == "main" then main else run_code a b

run_code player house = do
        putStrLn ""
        putStrLn ("Now you are in the " ++ (get_name (get_player_room player house)) ++ ".")
        putStrLn "What do you want to do?"
        putStr "> "
        line <- getLine
        -- putStrLn ""
        let line_list = (splitOn " " line)
        if      line == "help"                      then help "run_code" player house
        else if line == "exit"                      then main
        else if line == "search room"               then do 
                                                        putStrLn ("The objects in room: " ++ (intercalate ", " (map get_name (get_objects (get_player_room player house)))))
                                                        run_code player house
        else if line == "check bag"                 then do 
                                                        let i = (get_bag_item player)
                                                        putStrLn ("Your bag have: " ++ (show (length i)) ++ " items" ++ (show_bag_item i 1))
                                                        run_code player house
        else if head line_list == "search"          then do
                                                        
                                                        putStrLn ("You input :" ++ head (tail line_list))
                                                        run_code player house
        else do
            putStrLn ("wong input: '" ++ line ++ "' Please try again.")
            run_code player house
        


        -- ++ (list_to_string ", " (get_bag_item player1))