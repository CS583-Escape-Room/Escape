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
    get_id            r = room_id r
    get_name          r = room_name r

-- | instance the Objects's id and name.
instance Getfunctor Objects where
    get_id            o = object_id o
    get_name          o = object_name o

-- | instance the Item's id and name.
instance Getfunctor Item where
    get_id            i = item_id i
    get_name          i = item_name i

-- get the status.
get_status :: Objects -> Bool
get_status o = object_status o

-- get the lock.
get_lock :: Objects -> Lock
get_lock o = object_lock o

-- get the type.
get_type :: Objects -> String
get_type o = object_type o

-- get the connect room.
get_connect :: Objects -> String
get_connect o = object_connect o

-- This function can get the objects in a room.
get_objects :: Room -> [Objects]
get_objects r = room_objects r

-- This function can get the items in a object.
get_items :: Objects -> [Item]
get_items o = object_items o

-- This function can show the item information.
get_info :: Item -> String
get_info i = item_info i

-- get the information when obj is lock.
get_lock_info :: Objects -> String
-- get_lock_info (Objects {object_lock_info=info}) = info
get_lock_info o = object_lock_info o

-- get the information when obj is unlock.
get_unlock_info :: Objects -> String
get_unlock_info o = object_unlock_info o

-- This function get all item in the player bag.
get_location :: Player -> Int
get_location p = player_location p

-- get the player items in the bag.
get_bag_item :: Player -> [Item]
get_bag_item p = player_bag p

-----------------------------------------------------------------------------------------------------------------------------------------
-- | In this section all implement the function that the player needs.
-----------------------------------------------------------------------------------------------------------------------------------------
-- This function show the player room.
get_player_room :: Player -> House -> Room
get_player_room _ []     = no_room
get_player_room p (b:bs) = if (get_id b) == (get_location p) then b else get_player_room p bs

-- This function find the object in list of objects by name.
get_obj_by_name :: [Objects] -> String -> Objects
get_obj_by_name (o:os) b = if (get_name o == b) then o else get_obj_by_name os b

-- This function add the item in the player bag.
add_item_in_bag :: Player -> [Item] -> Player
add_item_in_bag p i = Player (get_location p) ((get_bag_item p) ++ i)

-- This function remove the item.
remove_item :: [Objects] -> Objects -> [Objects]
remove_item (o:os) obj = if o == obj then (Objects (get_id o) (get_name o) [] (get_connect o) (get_type o) (get_lock_info o) "This Object have been search." True (get_lock o):os)
                        else (o:remove_item os obj)

-- This function remove the item in a object.
remove_item_in_obj :: Int -> House -> Objects -> House
remove_item_in_obj id (h:hs) o = if get_id h == id then ((Room (get_id h) (get_name h) (remove_item (get_objects h) o)):hs)
                                 else (h:remove_item_in_obj id hs o)

-- This function open the lock.
unlock :: [Objects] -> Objects -> [Objects]
unlock (o:os) obj = if o == obj then (Objects (get_id o) (get_name o) [] (get_connect o) (get_type o) (get_lock_info o) (get_unlock_info o) True (get_lock o):os)
                    else (o:unlock os obj)

-- This function wants to open the lock door
unlock_door :: Int -> House -> Objects -> House
unlock_door id (h:hs) o = if get_id h == id then (Room (get_id h) (get_name h) (unlock (get_objects h) o):hs)
                          else (h:unlock_door id hs o)

-- This function find the specific type in object list.
get_objects_by_type :: String -> [Objects] -> [Objects]
get_objects_by_type t []     = []
get_objects_by_type t (o:os) = if get_type o == t then (o:get_objects_by_type t os)
                               else get_objects_by_type t os

-- This function want to find the door that can connect to.
get_obj_by_connect :: String -> [Objects] -> Objects
get_obj_by_connect c []     = no_object
get_obj_by_connect c (o:os) = if get_connect o == c then o
                              else get_obj_by_connect c os

-- This function wants to find the room in house by name.
get_room_by_name :: String -> House -> Room
get_room_by_name roomname []     = no_room
get_room_by_name roomname (h:hs) = if get_name h == roomname then h 
                                   else get_room_by_name roomname hs

--
-- | "check bag" instruction.
-- This is the item style.
item_style a n = "\n======================" ++ 
                 "\nItem Number : " ++ show n ++
                 "\nItem Name   : " ++ (get_name a) ++
                 "\nInformation : " ++ (get_info a)

-- This function show the item in the player bag.
show_bag_item :: [Item] -> Int -> String
show_bag_item []     n = "\nNothing"
show_bag_item (a:[]) n = item_style a n
show_bag_item (a:as) n = (item_style a n) ++ (show_bag_item as (n+1))

-- This function short the objects obj type
o_obj :: Int -> String -> [Item] -> String -> String -> Bool -> Lock -> Objects
o_obj  a b c f g h i = Objects a b c "" "obj" f g h i

-- This function short the objects door type
o_door :: Int -> String -> String -> String -> Bool -> Lock -> Objects
o_door a b d f h i   = Objects a b [] d "door" f "" h i

-- This function replace the room which is not found
no_room :: Room
no_room = Room 999 "No search room" []

-- This function replace the objects which is not found
no_object :: Objects
no_object = Objects 0 "Nothing" [] "" "" "" "" False None