module Escape_house where

import Escape_type
import Escape_func (o_door, o_obj)


-- | Item
--                 id   name                   info
ironKey     = Item 0    "iron key"             "A key which can open something."
redKey      = Item 1    "red key"              "A key which can open something."
sliverKey   = Item 2    "sliver key"           "A key which can open something."
paper1      = Item 3    "a small paper"        "There is a string of numbers written on the paper: OSU ADV FUNCTIONAL PROGRAMMING CS*** "
yellowKey   = Item 4    "yellow key"           "A key which can open something."
whiteKey    = Item 5    "white key"            "A key which can open something."
paper2      = Item 6    "another small paper"  "There is a string of numbers written on the paper: HelloWorld"
ironStick   = Item 7    "iron stick"           "This stick looks very hard"
battery     = Item 9    "battery"              "A AA battery"


-- | Objects in living room
--               id name                              item        lock_info                                   unlock_info                         status  lock
object11 = o_obj 11 "the left drawer of TV cabinet"   []          ""                                          "Here is nothing"                   True    None
object12 = o_obj 12 "the right drawer of TV cabinet"  [battery]   "It's locked. It has a yellow key hole"     "It's opened by your yellow key."   False   (Key yellowKey)
object13 = o_obj 13 "TV"                              [redKey]    ""                                          "you find a key behind the TV"      True    None
object14 = o_obj 14 "sofa"                            []          ""                                          "Here is nothing"                   True    None
object15 = o_obj 15 "trash can"                       []          ""                                          "Here is nothing."                  True    None

-- | Objects in bedroom
--               id name              item        lock_info                           unlock_info                             status  lock
object21 = o_obj 21 "a bed"           [ironStick] ""                                  "You find a iron stick under the bed."  True    None 
object22 = o_obj 22 "a wardrobe"      []          ""                                  "Here is nothing."                      True    None
object23 = o_obj 23 "a bedside table" [yellowKey] "It has a red keyhole"              "It's opened by your red key."          False   (Key redKey)
object24 = o_obj 24 "slippers"        []          ""                                  "Here is nothing."                      True    None 
object25 = o_obj 25 "a box"           [whiteKey]  "It's locked. It has a battery bay" "It's opened."                          False   (Key battery) 

-- | Objects in bathroom
--               id name              item        lock_info                           unlock_info                                 status  lock
object31 = o_obj 31 "washbasin"       []          ""                                  "Here is nothing."                          True    None
object32 = o_obj 32 "a mirror"        [sliverKey] ""                                  "You find a sliver key behind of mirror"    True    None
object33 = o_obj 33 "a toilet"        []          ""                                  "Here is nothing."                          True    None
object34 = o_obj 34 "a glass bottle"  [paper1]    "There is a paper in this bottle."  "You broken the bottom get the paper."      False   (Key ironStick)


-- | Objects in study
--               id name                          item        lock_info                                                   unlock_info                                 status  lock
object41 = o_obj 41 "a bookcase"                  []          ""                                                          "Here is nothing."                          True    None 
object42 = o_obj 42 "a strongbox"                 [ironKey]   "This strongbox need a password"                            "You use the password open this strongbox"  False   (Password "HelloWorld")
object43 = o_obj 43 "a diary on a writing desk"   [paper2]    "This diary has a combination lock. It needs 3 numbers."    "Your password is right. "                  False   (Password "583") 
object44 = o_obj 44 "a chair"                     []          ""                                                          "Here is nothing."                          True    None 
object45 = o_obj 45 "a trash can"                 []          ""                                                          "Here is nothing."                          True    None 


-- Door
--              id name               connect         lock_info                               status  lock
door12 = o_door 51 "a blue door"      "bedroom"       ""                                      True    None
door14 = o_door 52 "a wooden door"    "study"         "This door has a sliver keyhole"        False   (Key sliverKey) 
door21 = o_door 53 "a blue door"      "living room"   ""                                      True    None 
door23 = o_door 54 "a white door"     "bathroom"      "This door has a white keyhole"         False   (Key whiteKey)
door32 = o_door 55 "a white door"     "bedroom"       ""                                      True    None
door41 = o_door 56 "a wooden door"    "living room"   ""                                      True    None 

--              id name     connect lock_info                                                 status  lock
door00 = o_door 0  "exit"   "exit"  "This is a iron door. You have to escape from this door." False (Key ironKey)

-- | Room
--                 id name           objects
livingRoom  = Room 1  "living room"  [object11, object12, object13, object14, object15, door12, door14, door00]
bedroom     = Room 2  "bedroom"      [object21, object22, object23, object24, object25, door21, door23]
bathroom    = Room 3  "bathroom"     [object31, object32, object33, object34, door32]
study       = Room 4  "study"        [object41, object42, object43, object44, object45, door41]
-- | exit: a special room
escapedoor  = Room 0  "exit"         []

-- | House
house1 = [livingRoom, bedroom, bathroom, study, escapedoor]

-- | Player
player1 = Player 1 []
