module Escape_type where

type House = [Room]

-- This type is for room.
data Room = Room {
                 room_id      :: Int,
                 room_name    :: String,
                 room_objects :: [Objects]
                --  room_status  :: Bool,
                --  room_door    :: [Door]
                --  room_key     :: Item
                 } 
                 deriving (Eq, Show, Read)

-- data Door = Door {
--                  door_id        :: Int,
--                  door_name      :: String,
--                  door_connect   :: Int,
--                  door_status    :: Bool,
--                  door_key       :: Item
--                  }
--                  deriving (Eq, Show, Read)


data Objects = Objects {
                       object_id            :: Int,
                       object_name          :: String,
                       object_items         :: [Item],
                       object_connect       :: String,
                       object_type          :: String,
                       object_lock_info     :: String,
                       object_unlock_info   :: String,
                       object_status        :: Bool,
                       object_lock          :: Lock
                       }
                       deriving (Eq, Show, Read)

data Item = Item {
                 item_id   :: Int,
                 item_name :: String,
                 item_info :: String
                 }
                 deriving (Eq, Show, Read)

data Player = Player {
                     player_location    :: Int,
                     player_bag         :: [Item]
                     }
                     deriving (Eq, Show, Read)


data Cmd
    = Help String
    | Exit
    | SearchRoom Room
    | SearchObj String Objects
    | SearchDoor String Objects
    | Search Room String
    | Bag
    | Mov Room String
    | Other String
    deriving(Eq, Show, Read)

data Lock
    = None
    | Password String
    | Key Item
    deriving(Eq, Show, Read)