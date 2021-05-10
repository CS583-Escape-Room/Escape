module Escape_func where

-- | import the file
import Escape_type

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

-- | function class
class Funcfunctor t where
    get_id            :: t -> Int
    get_name          :: t -> String
    get_status        :: t -> Bool
    get_key           :: t -> Item
    

-- | instance the Room
instance Funcfunctor Room where
    get_id            (Room {room_id=id, room_name=name, room_objects=obj, room_door=door}) = id
    get_name          (Room {room_id=id, room_name=name, room_objects=obj, room_door=door}) = name

-- | instance the Objects
instance Funcfunctor Objects where
    get_id            (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = id
    get_name          (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = name
    get_status        (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = stat
    get_key           (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = key

-- | instance the Door
instance Funcfunctor Door where
    get_id            (Door {door_id=id, door_name=name, door_connect=room, door_status=stat, door_key=key}) = id
    get_name          (Door {door_id=id, door_name=name, door_connect=room, door_status=stat, door_key=key}) = name
    get_status        (Door {door_id=id, door_name=name, door_connect=room, door_status=stat, door_key=key}) = stat
    get_key           (Door {door_id=id, door_name=name, door_connect=room, door_status=stat, door_key=key}) = key

-- | instance the Item
instance Funcfunctor Item where
    get_id            (Item {item_id=id, item_name=name, item_info=info}) = id
    get_name          (Item {item_id=id, item_name=name, item_info=info}) = name



get_door :: Room -> [Door]
get_door (Room {room_id=id, room_name=name, room_objects=obj, room_door=door}) = door

get_objects :: Room -> [Objects]
get_objects (Room {room_id=id, room_name=name, room_objects=obj, room_door=door}) = obj

get_items :: Objects -> [Item]
get_items (Objects {object_id=id, object_name=name, object_items=items, object_status=stat, object_key=key}) = items

get_info :: Item -> String
get_info (Item {item_id=id, item_name=name, item_info=info}) = info


