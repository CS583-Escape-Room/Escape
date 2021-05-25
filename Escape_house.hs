module Escape_house where

import Escape_type


-- | Item
--   base item
nothing = Item {item_id=0, item_name="", item_info=""}
nokey = Item {item_id=0, item_name="", item_info="This is open."}

--   key
rkey1 = Item {item_id=1, item_name="room key", item_info="A key which can open the door."}
dkey1 = Item {item_id=2, item_name="desk key", item_info="A key which can open the desk."}
redkey1 = Item {item_id=4, item_name="red key", item_info="This key can do something."}

--   item
ball = Item {item_id=3, item_name="ball", item_info="This ball can do nothing."}

-- | Objects
object1 = Objects {object_id=1, object_name="desk", object_items=[rkey1], object_connect= -1, object_type="obj", object_status=False, object_key=dkey1}
object2 = Objects {object_id=2, object_name="chair", object_items=[dkey1], object_connect= -1, object_type="obj", object_status=True, object_key=nokey}
object3 = Objects {object_id=3, object_name="book", object_items=[], object_connect= -1, object_type="obj", object_status=True, object_key=nokey}
object4 = Objects {object_id=4, object_name="box", object_items=[], object_connect= -1, object_type="obj", object_status=True, object_key=nokey}

-- Door
door1 = Objects {object_id=5, object_name="exit-door", object_items=[], object_connect=0, object_type="door", object_status=True, object_key=nokey}
-- door1 = Door {door_id=1, door_name="exit", door_connect=0, door_status=False, door_key=rkey1}

-- | Room
room1 = Room {room_id=1, room_name="room 1", room_objects=[object1, object2, object3, object4, door1], room_door=[]}

-- | House
house1 = [room1]

-- | Player
player1 = Player {player_location=1, player_bag=[ball, redkey1]}