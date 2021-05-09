module Escape_type where

type House = [Room]

data Room = Room {
                 room_id     :: Int,
                 room_name   :: String,
                 room_objects :: [Objects],
                 room_status :: Bool,
                 room_key    :: Item
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