module Escape_type where

type House = [Room]

data Room = Room {
                 room_id      :: Int,
                 room_name    :: String,
                 room_objects :: [Objects],
                 room_status  :: Bool,
                 room_door    :: [Door]
                --  room_key     :: Item
                 } 
                 deriving (Eq,Show)

data Door = Door {
                 door_id :: Int,
                 door_name :: String,
                 door_connect :: Int,
                 door_status :: Bool,
                 door_key :: Item
                 }
                 deriving (Eq,Show)

data Objects = Objects {
                       object_id     :: Int,
                       object_name   :: String,
                       object_items   :: [Item],
                       object_status :: Bool,
                       object_key    :: Item
                       }
                       deriving (Eq,Show)

data Item = Item {
                 item_id   :: Int,
                 item_name :: String,
                 item_info :: String
                 }
                 deriving (Eq,Show)

data Player = Player {
                     player_location :: Int,
                     player_bag :: [Item]
                     }
                     deriving (Eq,Show)