module Escape_func where

-- | import the file
import Escape_type
import Data.List
import Data.List.Split

-------------------------------------------------------------------------------------------------------------------
-- | All function in this section implement the basic get.
-- function class
class Getfunctor t where
    -- get the id
    get_id            :: t -> Int
    -- get the name
    get_name          :: t -> String

-- | instance the Room's id, name, object, and door
instance Getfunctor Room where
    get_id            (Room {room_id=id}) = id
    get_name          (Room {room_name=name}) = name

-- | instance the Objects's id, name, item, status, and key
instance Getfunctor Objects where
    get_id            (Objects {object_id=id}) = id
    get_name          (Objects {object_name=name}) = name

-- | instance the Door's id, name, connect, status, and key
-- instance Getfunctor Door where
--     get_id            (Door {door_id=id}) = id
--     get_name          (Door {door_name=name}) = name
--     get_status        (Door {door_status=stat}) = stat
--     get_key           (Door {door_key=key}) = key

-- | instance the Item's id, name, and info
instance Getfunctor Item where
    get_id            (Item {item_id=id}) = id
    get_name          (Item {item_name=name}) = name

-- This function can know the room have how many doors and show the door information.
-- get_door :: Room -> [Door]
-- get_door        (Room {room_door=door}) = door

-- get the status
get_status :: Objects -> Bool
get_status (Objects {object_status=state}) = state

-- get the key
get_key :: Objects -> Item
get_key (Objects {object_key=key}) = key

get_type :: Objects -> String
get_type (Objects {object_type=t}) = t

get_connect :: Objects -> String
get_connect (Objects {object_connect=connect}) = connect

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
get_location :: Player -> Int
get_location (Player {player_location=id}) = id

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
get_player_room _ []     = Room {room_id=999, room_name="No search room", room_objects=[]}
get_player_room p (b:bs) = if (get_id b) == (get_location p) then b else get_player_room p bs

get_obj_by_name :: [Objects] -> String -> Objects
get_obj_by_name (o:os) b = if (get_name o == b) then o else get_obj_by_name os b

add_item_in_bag :: Player -> [Item] -> Player
add_item_in_bag p i = Player {player_location=get_location p, player_bag=(get_bag_item p) ++ i}

remove_obj :: [Objects] -> Objects -> [Objects]
remove_obj (o:os) obj = if o == obj then (Objects {object_id=get_id o, object_name=get_name o, object_items=[], object_connect=get_connect o, object_type=get_type o, object_status=True, object_key=get_key o}:os)
                        else (o:remove_obj os obj)

remove_item_in_obj :: Int -> House -> Objects -> House
remove_item_in_obj id (h:hs) o = if get_id h == id then [Room {room_id=get_id h, room_name=get_name h, room_objects=remove_obj (get_objects h) o}] ++ hs
                                 else (h:remove_item_in_obj id hs o)

unluck :: [Objects] -> Objects -> [Objects]
unluck (o:os) obj = if o == obj then (Objects {object_id=get_id o, object_name=get_name o, object_items=[], object_connect=get_connect o, object_type=get_type o, object_status=True, object_key=get_key o}:os)
                    else (o:unluck os obj)

unluck_door :: Int -> House -> Objects -> House
unluck_door id (h:hs) o = if get_id h == id then (Room {room_id=get_id h, room_name=get_name h, room_objects=unluck (get_objects h) o}:hs)
                          else (h:unluck_door id hs o)

get_objects_by_type :: String -> [Objects] -> [Objects]
get_objects_by_type t []     = []
get_objects_by_type t (o:os) = if get_type o == t then (o:get_objects_by_type t os)
                               else get_objects_by_type t os

get_obj_by_connect :: String -> [Objects] -> Objects
get_obj_by_connect c []     = Objects {object_id=0, object_name="Nothing", object_items=[], object_connect="", object_type="", object_status=False, object_key=Item {item_id=0, item_name="", item_info=""}}
get_obj_by_connect c (o:os) = if get_connect o == c then o
                              else get_obj_by_connect c os

get_room_by_name :: String -> House -> Room
get_room_by_name roomname []     = Room {room_id=999, room_name="No search room", room_objects=[]}
get_room_by_name roomname (h:hs) = if get_name h == roomname then h else get_room_by_name roomname hs
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