module Escape_func where

-- | import the file
import Escape_type
import Data.List
import Data.List.Split

-- -- | test case
-- nothing = Item {item_id=0, item_name="", item_info=""}
-- nokey = Item {item_id=0, item_name="", item_info="This is open."}
-- rkey1 = Item {item_id=1, item_name="Room key", item_info="A key which can open the door."}
-- dkey1 = Item {item_id=2, item_name="Desk key", item_info="A key which can open the desk."}
-- object1 = Objects {object_id=1, object_name="Desk", object_items=[rkey1], object_status=False, object_key=dkey1}
-- object2 = Objects {object_id=2, object_name="Chair", object_items=[dkey1], object_status=True, object_key=nokey}
-- object3 = Objects {object_id=3, object_name="Book", object_items=[], object_status=True, object_key=nokey}
-- object4 = Objects {object_id=4, object_name="Box", object_items=[], object_status=True, object_key=nokey}
-- door1 = Door {door_id=1, door_name="Exit", door_connect=0, door_status=False, door_key=rkey1}
-- room1 = Room {room_id=1, room_name="room 1", room_objects=[object1, object2, object3, object4], room_door=[door1]}
-- player1 = Player {player_location=1, player_bag=[]}
-- house = [room1]

-------------------------------------------------------------------------------------------------------------------
-- | All function in this section implement the basic get.
-- function class
class Getfunctor t where
    -- get the id
    get_id            :: t -> Int
    -- get the name
    get_name          :: t -> String
    -- get the status
    get_status        :: t -> Bool
    -- get the key
    get_key           :: t -> Item

-- | instance the Room's id, name, object, and door
instance Getfunctor Room where
    get_id            (Room {room_id=id}) = id
    get_name          (Room {room_name=name}) = name
    get_status        _ = False
    get_key           _ = Item {item_id=0, item_name="", item_info=""}

-- | instance the Objects's id, name, item, status, and key
instance Getfunctor Objects where
    get_id            (Objects {object_id=id}) = id
    get_name          (Objects {object_name=name}) = name
    get_status        (Objects {object_status=stat}) = stat
    get_key           (Objects {object_key=key}) = key

-- | instance the Door's id, name, connect, status, and key
instance Getfunctor Door where
    get_id            (Door {door_id=id}) = id
    get_name          (Door {door_name=name}) = name
    get_status        (Door {door_status=stat}) = stat
    get_key           (Door {door_key=key}) = key

-- | instance the Item's id, name, and info
instance Getfunctor Item where
    get_id            (Item {item_id=id}) = id
    get_name          (Item {item_name=name}) = name
    get_status        _ = False
    get_key           _ = Item {item_id=0, item_name="", item_info=""}

-- This function can know the room have how many doors and show the door information.
get_door :: Room -> [Door]
get_door        (Room {room_door=door}) = door

-- This function can get the objects in a room.
get_objects :: Room -> [Objects]
get_objects     (Room {room_objects=obj}) = obj

-- This function can get the items in a object.
get_items :: Objects -> [Item]
get_items       (Objects {object_items=items}) = items

-- This function can show the item information.
get_info :: Item -> String
get_info        (Item {item_info=info}) = info

-- This function get all item in the player bag.
get_bag_item :: Player -> [Item]
get_bag_item    (Player {player_bag=bag}) = bag

-----------------------------------------------------------------------------------------------------------------------------------------
-- | In this section all implement the function that the player needs.
-----------------------------------------------------------------------------------------------------------------------------------------
--
--
-- 
-- This function show the player room.
get_player_room :: Player -> House -> Room
get_player_room _                                             []     = Room {room_id=999, room_name="No search room", room_objects=[], room_door=[]}
get_player_room (Player {player_location=id, player_bag=bag}) (b:bs) = if (get_id b) == id then b else get_player_room (Player {player_location=id, player_bag=bag}) bs

get_player_id :: Player -> Int
get_player_id Player {player_location=id, player_bag=bag} = id

get_obj_by_name :: [Objects] -> String -> Objects
get_obj_by_name (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}:as) b = if name == b then Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key} else get_obj_by_name as b

add_item_in_bag :: Player -> [Item] -> Player
add_item_in_bag (Player {player_location=id, player_bag=bag}) i = Player {player_location=id, player_bag=bag ++ i}

remove_obj :: [Objects] -> Objects -> [Objects]
remove_obj (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}:os) obj = if Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key} == obj then 
                                                                                                                            [Objects {object_id=id, object_name=name, object_items=[], object_status=True, object_key=key}] ++ os
                                                                                                                        else [Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}] ++ remove_obj os obj

remove_item_in_obj :: Int -> House -> Objects -> House
remove_item_in_obj id (h:hs) o = if get_id h == id then [Room {room_id=get_id h, room_name=get_name h, room_objects=remove_obj (get_objects h) o, room_door=get_door h}] ++ hs
                                 else [h] ++ remove_item_in_obj id hs o

-- 
--
-- | "check bag" instruction.
--   This is the item style.
item_style a n = "\n======================" ++ 
                 "\nItem Number : " ++ show n ++
                 "\nItem Name   : " ++ (get_name a) ++
                 "\nInformation : " ++ (get_info a)

--   This function show the item in the player bag.
show_bag_item :: [Item] -> Int -> String
show_bag_item []     n = "\nNothing"
show_bag_item (a:[]) n = item_style a n
show_bag_item (a:as) n = (item_style a n) ++ (show_bag_item as (n+1))

-- class ToStrfunctor t where
--     list_to_string :: [t] -> String -> String
    
-- instance ToStrfunctor Objects where
--     list_to_string [] b = "Nothing"
--     list_to_string (a:as) b = show "123" ++ b ++ list_to_string as b

-- instance ToStrfunctor Item where
--     list_to_string [] b = "Nothing"
--     list_to_string (a:as) b = show "123" ++ b ++ list_to_string as b
-- list_to_string :: [Item] -> String -> String
-- list_to_string [] b = "Nothing"
-- list_to_string ((Item {item_id=id, item_name=name, item_info=info}):as) b = name ++ b ++ list_to_string as b