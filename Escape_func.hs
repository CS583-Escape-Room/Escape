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

-- | instance the Room's id and name.
instance Getfunctor Room where
    get_id            (Room {room_id=id}) = id
    get_name          (Room {room_name=name}) = name

-- | instance the Objects's id and name.
instance Getfunctor Objects where
    get_id            (Objects {object_id=id}) = id
    get_name          (Objects {object_name=name}) = name

-- | instance the Item's id and name.
instance Getfunctor Item where
    get_id            (Item {item_id=id}) = id
    get_name          (Item {item_name=name}) = name

-- get the status.
get_status :: Objects -> Bool
get_status (Objects {object_status=state}) = state

-- get the lock.
get_lock :: Objects -> Lock
get_lock (Objects {object_lock=lock}) = lock

-- get the type.
get_type :: Objects -> String
get_type (Objects {object_type=t}) = t

-- get the connect room.
get_connect :: Objects -> String
get_connect (Objects {object_connect=connect}) = connect

-- This function can get the objects in a room.
get_objects :: Room -> [Objects]
get_objects (Room {room_objects=obj}) = obj

-- This function can get the items in a object.
get_items :: Objects -> [Item]
get_items (Objects {object_items=items}) = items

-- This function can show the item information.
get_info :: Item -> String
get_info (Item {item_info=info}) = info

-- get the information when obj is lock.
get_lock_info :: Objects -> String
get_lock_info (Objects {object_lock_info=info}) = info

-- get the information when obj is unlock.
get_unlock_info :: Objects -> String
get_unlock_info (Objects {object_unlock_info=info}) = info

-- This function get all item in the player bag.
get_location :: Player -> Int
get_location (Player {player_location=id}) = id

-- get the player items in the bag.
get_bag_item :: Player -> [Item]
get_bag_item (Player {player_bag=bag}) = bag

-----------------------------------------------------------------------------------------------------------------------------------------
-- | In this section all implement the function that the player needs.
-----------------------------------------------------------------------------------------------------------------------------------------
-- This function show the player room.
get_player_room :: Player -> House -> Room
get_player_room _ []     = Room {room_id=999, room_name="No search room", room_objects=[]}
get_player_room p (b:bs) = if (get_id b) == (get_location p) then b else get_player_room p bs

-- This function find the object in list of objects by name.
get_obj_by_name :: [Objects] -> String -> Objects
get_obj_by_name (o:os) b = if (get_name o == b) then o else get_obj_by_name os b

-- This function add the item in the player bag.
add_item_in_bag :: Player -> [Item] -> Player
add_item_in_bag p i = Player {player_location=get_location p, player_bag=(get_bag_item p) ++ i}

-- This function remove the item.
remove_item :: [Objects] -> Objects -> [Objects]
remove_item (o:os) obj = if o == obj then (Objects { object_id=get_id o, 
                                                    object_name=get_name o, 
                                                    object_items=[], 
                                                    object_connect=get_connect o, 
                                                    object_type=get_type o, 
                                                    object_lock_info=get_lock_info o, 
                                                    object_unlock_info="This Object have been search.", 
                                                    object_status=True, 
                                                    object_lock=get_lock o}:os)
                        else (o:remove_item os obj)

-- This function remove the item in a object.
remove_item_in_obj :: Int -> House -> Objects -> House
remove_item_in_obj id (h:hs) o = if get_id h == id then [Room {room_id=get_id h, room_name=get_name h, room_objects=remove_item (get_objects h) o}] ++ hs
                                 else (h:remove_item_in_obj id hs o)

-- This function open the lock.
unlock :: [Objects] -> Objects -> [Objects]
unlock (o:os) obj = if o == obj then (Objects { object_id=get_id o, 
                                                object_name=get_name o, 
                                                object_items=[], 
                                                object_connect=get_connect o, 
                                                object_type=get_type o, 
                                                object_lock_info=get_lock_info o, 
                                                object_unlock_info=get_unlock_info o, 
                                                object_status=True, 
                                                object_lock=get_lock o}:os)
                    else (o:unlock os obj)

-- This function wants to open the lock door
unlock_door :: Int -> House -> Objects -> House
unlock_door id (h:hs) o = if get_id h == id then (Room {room_id=get_id h, room_name=get_name h, room_objects=unlock (get_objects h) o}:hs)
                          else (h:unlock_door id hs o)

-- This function find the specific type in object list.
get_objects_by_type :: String -> [Objects] -> [Objects]
get_objects_by_type t []     = []
get_objects_by_type t (o:os) = if get_type o == t then (o:get_objects_by_type t os)
                               else get_objects_by_type t os

-- This function want to find the door that can connect to.
get_obj_by_connect :: String -> [Objects] -> Objects
get_obj_by_connect c []     = Objects {object_id=0, 
                                        object_name="Nothing", 
                                        object_items=[], 
                                        object_connect="", 
                                        object_type="", 
                                        object_lock_info="", 
                                        object_unlock_info="", 
                                        object_status=False, 
                                        object_lock=None}
get_obj_by_connect c (o:os) = if get_connect o == c then o
                              else get_obj_by_connect c os

-- This function wants to find the room in house by name.
get_room_by_name :: String -> House -> Room
get_room_by_name roomname []     = Room {room_id=999, room_name="No search room", room_objects=[]}
get_room_by_name roomname (h:hs) = if get_name h == roomname then h else get_room_by_name roomname hs

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