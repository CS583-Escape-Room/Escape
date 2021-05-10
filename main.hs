module Escape_main where

import Escape_func
import Escape_type
import Data.List

-- | test 
nothing = Item {item_id=0, item_name="", item_info=""}
nokey = Item {item_id=0, item_name="", item_info="This is open."}
rkey1 = Item {item_id=1, item_name="Room key", item_info="A key which can open the door."}
dkey1 = Item {item_id=2, item_name="Desk key", item_info="A key which can open the desk."}
object1 = Objects {object_id=1, object_name="Desk", object_items=[rkey1], object_status=False, object_key=dkey1}
object2 = Objects {object_id=2, object_name="Chair", object_items=[dkey1], object_status=True, object_key=nokey}
object3 = Objects {object_id=3, object_name="Book", object_items=[], object_status=True, object_key=nokey}
object4 = Objects {object_id=4, object_name="Box", object_items=[], object_status=True, object_key=nokey}
door1 = Door {door_id=1, door_name="Exit", door_connect=0, door_status=False, door_key=rkey1}
room1 = Room {room_id=1, room_name="room 1", room_objects=[object1, object2, object3, object4], room_door=[door1]}
player1 = Player {player_location=1, player_bag=[]}
house = [room1]


main = do
    putStrLn "Well come to play the Escape game. !!!"
    putStrLn "You can input the 'start' to play the game, or 'exit' to close the game."
    putStrLn "Also, you can type help to see the commend."
    line <- getLine
    if line == "exit" then return()
    else if line == "help" then help "main"
    else if line == "start" then run_code
    else do
        putStrLn ("wong input: '" ++ line ++ "' Please try again.")
        main

help = \x -> do
    putStrLn ""
    putStrLn "instructions                                  | Describing instructions"
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn "search 'object's name'                        | you can use this instruction to know what item in the object and get it."
    putStrLn "open 'door's id'                              | you can use this instruction to open the door."
    putStrLn "show_room                                     | you can use this instruction to show all object in your current room."
    putStrLn "check_bag                                     | you can use this instruction to check the bag items."
    putStrLn "move 'room's id'/ move 'room's name'          | you can use this instruction to move the player to the room which you input and the room must can accpect."
    putStrLn "-----------------------------------------------------------------------------------------------------------"
    putStrLn ""
    if x == "main" then main else run_code

run_code = do

        putStrLn "Now you are in room."
        line <- getLine
        if line == "help" then help "run_code"
        else if line == "exit" then main
        else if line == "show_room" then do putStrLn ("The objects in room: " ++ (intercalate ", " (map get_name (get_objects room1))))
                                            run_code
        else run_code