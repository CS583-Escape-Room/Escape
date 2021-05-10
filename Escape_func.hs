module Escape_func where

-- | import the file
import Escape_type

-- | test 
nothing = Item {item_id=0, item_name="", item_info=""}
nokey = Item {item_id=0, item_name="", item_info="This is open."}
rkey1 = Item {item_id=1, item_name="Room key", item_info="A key which can open the door."}
okey1 = Item {item_id=2, item_name="Desk key", item_info="A key which can open the desk."}
object1 = Objects {object_id=1, object_name="Desk", object_items=[rkey1], object_status=False, object_key=okey1}
object2 = Objects {object_id=2, object_name="Chair", object_items=[okey1], object_status=True, object_key=nokey}
room1 = Room {room_id=1, room_name="Main room", room_objects=[object1, object2], room_status=False, room_key=rkey1}
house = [room1]

-- | function class
class Funcfunctor t where
    get_id            :: t -> Int
    get_name          :: t -> String
    get_status        :: t -> Bool
    get_key           :: t -> Item
    

-- | instance the Room
instance Funcfunctor Room where
    get_id            (Room {room_id=id, room_name=name, room_objects=obj, room_status=stat, room_key=key}) = id
    get_name          (Room {room_id=id, room_name=name, room_objects=obj, room_status=stat, room_key=key}) = name
    get_status        (Room {room_id=id, room_name=name, room_objects=obj, room_status=stat, room_key=key}) = stat
    get_key           (Room {room_id=id, room_name=name, room_objects=obj, room_status=stat, room_key=key}) = key

-- | instance the Objects
instance Funcfunctor Objects where
    get_id            (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = id
    get_name          (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = name
    get_status        (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = stat
    get_key           (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = nokey

-- | instance the Item
instance Funcfunctor Item where
    get_id            (Item {item_id=id, item_name=name, item_info=info}) = id
    get_name          (Item {item_id=id, item_name=name, item_info=info}) = name
    get_status        (Item {item_id=id, item_name=name, item_info=info}) = True
    get_key           (Item {item_id=id, item_name=name, item_info=info}) = nothing





get_objects :: Room -> [Objects]
get_objects (Room {room_id=id, room_name=name, room_objects=obj, room_status=stat, room_key=key}) = obj

get_items :: Objects -> [Item]
get_items (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = items

get_info :: Item -> String
get_info (Item {item_id=id, item_name=name, item_info=info}) = info


