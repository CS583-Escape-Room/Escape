module Escape_house where

import Escape_type


-- | Item
--   base item
nothing = Item {item_id=0, item_name="", item_info=""}

--  item
redKey = Item {item_id=1, item_name="red key", item_info="A key which can open the door."}
sliverKey = Item {item_id=2, item_name="sliver key", item_info="A key which can open the desk."}
paper1 = Item {item_id=3, item_name="a small paper", item_info="There is a string of numbers written on the paper: OSU ADV FUNCTIONAL PROGRAMMING CS..."}
yellowKey = Item {item_id=4, item_name="yellow key", item_info="A key which can open the door."}
blueKey = Item {item_id=5, item_name="blue key", item_info="A key which can open the desk."}
paper2 = Item {item_id=6, item_name="another small paper", item_info="There is a string of numbers written on the paper: HelloWorld"}
ironStick = Item {item_id=7, item_name="iron stick", item_info="This stick looks very hard"}
ironKey = Item {item_id=0, item_name="iron key", item_info="A key which can open the desk."}


-- | Objects in living room
object11 = Objects {object_id=11, object_name="the left drawer of TV cabinet", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing"}
object12 = Objects {object_id=12, object_name="the right drawer of TV cabinet", object_items=[battery], object_connect="", object_type="obj", object_status=False, object_key=Key ykey, object_lock_info="It's locked. It has a yellow key hole", object_unlock_info="It's opened by your yellow key."}
object13 = Objects {object_id=13, object_name="TV", object_items=[redKey], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="you find a key behind the TV"}
object14 = Objects {object_id=14, object_name="sofa", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing"}
object15 = Objects {object_id=15, object_name="trash can", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}

-- | Objects in bedroom
object21 = Objects {object_id=21, object_name="a bed", object_items=[ironStick], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="You find a iron stick under the bed."}
object22 = Objects {object_id=22, object_name="a wardrobe", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="here is nothing."}
object23 = Objects {object_id=23, object_name="a bedside table", object_items=[yellowKey], object_connect="", object_type="obj", object_status=False, object_key=Key rkey, object_lock_info="It has a red keyhole", object_unlock_info="It's opened by your red key."}
object24 = Objects {object_id=24, object_name="slippers", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}
object25 = Objects {object_id=25, object_name="a box", object_items=[blueKey], object_connect="", object_type="obj", object_status=False, object_key=Key battery, object_lock_info="It's locked. It has a battery bay", object_unlock_info="It's opened."}

-- | Objects in bathroom
object31 = Objects {object_id=31, object_name="washbasin", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}
object32 = Objects {object_id=32, object_name="a mirror", object_items=[sliverKey], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="You find a sliver key behind of mirror"}
object33 = Objects {object_id=33, object_name="a toilet", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}
object34 = Objects {object_id=34, object_name="a glass bottle", object_items=[paper1], object_connect="", object_type="obj", object_status=False, object_key=None, object_lock_info="There is a paper in this bottle.", object_unlock_info="You broken the bottom get the paper."}


-- | Objects in study
object41 = Objects {object_id=41, object_name="a bookcase", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}
object42 = Objects {object_id=42, object_name="a strongbox", object_items=[ironKey], object_connect="", object_type="obj", object_status=False, object_key=Password "HelloWorld", object_lock_info="This strongbox need a password", object_unlock_info="You use the password open this strongbox"}
object43 = Objects {object_id=43, object_name="a diary on a writing desk", object_items=[paper2], object_connect="", object_type="obj", object_status=False, object_key=Password "583", object_lock_info="This diary has a combination lock. It needs 3 numbers.", object_unlock_info="Your password is right. "}
object44 = Objects {object_id=44, object_name="a chair", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}
object45 = Objects {object_id=45, object_name="a trash can", object_items=[], object_connect="", object_type="obj", object_status=True, object_key=None, object_lock_info="", object_unlock_info="Here is nothing."}


-- Door
door12 = Objects {object_id=51, object_name="a blue door", object_items=[], object_connect="bathroom", object_type="door", object_status=True, object_key=None, object_lock_info="", object_unlock_info=""}
door14 = Objects {object_id=52, object_name="a wooden door", object_items=[], object_connect="studyRoom", object_type="door", object_status=False, object_key=Key blueKey, object_lock_info="This door has a blue keyhole", object_unlock_info=""}
door21 = Objects {object_id=53, object_name="a blue door", object_items=[], object_connect="livingRoom", object_type="door", object_status=True, object_key=None, object_lock_info="", object_unlock_info=""}
door23 = Objects {object_id=54, object_name="a white door", object_items=[], object_connect="bathroom", object_type="door", object_status=False, object_key=Key sliverKey, object_lock_info="This door has a sliver keyhole", object_unlock_info=""}
door32 = Objects {object_id=55, object_name="a white door", object_items=[], object_connect="bedroom", object_type="door", object_status=True, object_key=None, object_lock_info="", object_unlock_info=""}
door41 = Objects {object_id=56, object_name="a wooden door", object_items=[], object_connect="livingRoom", object_type="door", object_status=True, object_key=None , object_lock_info="", object_unlock_info=""}


door0 = Door {door_id=0, door_name="exit", door_connect=outdoor, door_status=False, door_key=Key ironKey, object_lock_info="", object_unlock_info="This is a iron door. You have to escape from this door."}

-- | Room
livingRoom = Room {room_id=1, room_name="living room", room_objects=[object11, object12, object13, object14, door12,door14]}
bedroom = Room {room_id=2, room_name="bedroom", room_objects=[object21, object22, object23, object24, door21,door23]}
bathroom = Room {room_id=3, room_name="bathroom", room_objects=[object31, object32, object33, object34, door32]}
study = Room {room_id=4, room_name="study", room_objects=[object41, object42, object43, object44, door41]}
--| exit: a special room
outdoor = Room {room_id=0, room_name="outdoot", room_objects=[]}


-- | House
house1 = [livingRoom, bedroom, bathroom, study, outdoor]


-- | Player
player1 = Player {player_location=1, player_bag=[]}
