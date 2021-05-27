module Escape_type where
-- | This file store all type that the game use.

-- This type store all room in this House.
type House = [Room]

-- This data is for the room structure in the house. 
data Room = Room {
                 -- room_id store the room unique numbers.
                 room_id      :: Int,
                 -- room_name store the room name like 'living room'.
                 room_name    :: String,
                 -- room_objects store the object list in the room.
                 room_objects :: [Objects]
                 } 
                 deriving (Eq, Show, Read)

-- This data is for the object structure in the room. 
-- Objects have two type now. 
-- Different for two type:
--      'obj'    : use items
--      'door'   : use connect
data Objects = Objects {
                       -- object_id store the object unique numbers. 
                       object_id            :: Int,
                       -- object_name store the object name like 'desk'.
                       object_name          :: String,
                       -- object_items store the items which are in this object.
                       object_items         :: [Item],
                       -- object_connect store the door can go to which room.
                       object_connect       :: String,
                       -- object_type store the object is door or object.
                       object_type          :: String,
                       -- object_lock_info store the information that the door is lock.
                       object_lock_info     :: String,
                       -- object_unlock_info store the information that the door is unlock.
                       object_unlock_info   :: String,
                       -- object_status store the object is lock or not 
                       -- 'False' is lock 
                       -- 'True' is unlock.
                       object_status        :: Bool,
                       -- object_lock store the object lock type need a key or need to input password
                       object_lock          :: Lock
                       }
                       deriving (Eq, Show, Read)

-- This data is for the item structure in the object. 
data Item = Item {
                 -- item_id store the item unique numbers. 
                 item_id   :: Int,
                 -- item_name store the item name like 'a small paper'. 
                 item_name :: String,
                 -- item_info store the infomation for the item. 
                 item_info :: String
                 }
                 deriving (Eq, Show, Read)

-- This data is for the Player. 
data Player = Player {
                     -- player_location store the room id where the plater is.
                     player_location    :: Int,
                     -- player_bag store item that the play get.
                     player_bag         :: [Item]
                     }
                     deriving (Eq, Show, Read)

-- This data is for the Command that player input. 
data Cmd
    -- show the command.
    = Help String
    -- leave the game.
    | Exit
    -- show whole room objects.
    | SearchRoom Room
    -- search the object that player input.
    | SearchObj String Objects
    -- search the door that player input.
    | SearchDoor String Objects
    -- search object or door.
    | Search Room String
    -- show the item in the player bag.
    | Bag
    -- move the player to the another room.
    | Mov Room String
    -- The wrong input for player.
    | Other String
    deriving(Eq, Show, Read)

-- This data is for the lock type.
data Lock
    -- No lock
    = None
    -- need to input password
    | Password String
    -- need a key or item
    | Key Item
    deriving(Eq, Show, Read)