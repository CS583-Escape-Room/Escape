# Escape

<!-- Instell the packages -->
<!-- It will take many times -->
### Before you run the code you need to install those package.
cabal install fgl  
cabal install split  


How to play this game:  
------
1. Download all files then use `ghci` to load `main.hs`.
2. Type in `main` to start this program.
3. Type in `start` to begin this game. Now you can see `Now you are in the room 1. What do you want to do?`
4. During playing this game, you can type in words. If what you type in can be an acceptable command, program will accept it can make an action.  
* Acceptable command:  
     * `search "object's name"`                               | you can use this instruction to know what item in the object and get it, or check the door."  
     * `search room`                                        | you can use this instruction to search all object in your current room."  
     * `check bag`                                          | you can use this instruction to check the bag items."  
     * `move "room's name"`                                   | you can use this instruction to move the player to the room which you input and the room must can accpect."  
     * `exit`                                               | you can use this instruction to exit the game."  
* Example:  
     * type in `search room`                                  | you can see `The objects in room: desk, chair, book, box, exit door`  
     * type in `search desk`                                  | you can see `desk is lock, you need something.`  
     * type in `check bag`                                    | you can see `Your bag have 2 items ......`
     * type in `exit`                                         | you can exit this game
     * type in `search bag(non-existent object)`              | you can see `This room does not have 'bag' object.`  
     * type in `open door(non-existent command)`              | you can see `wrong input: 'open door' Please try again.`

<!-- 1. A brief description of your project goals (you can take this from your project proposal), and your current progress toward achieving those goals.
     2. Instructions for how to run your project (e.g. which file to load in GHCi), including several example inputs, if applicable.
     3. In Milestone #1: a list of 2–4 design questions that you have about your project, that you would like to discuss during the workshop.-->
Milestones(1):  
----- 
1. This is a graphic room escape decryption game. The user's goal is to escape the room through interaction with map objects.  
   We have build the basic project structure. Based on this structure, we have build the three function:   
   'search room': can show the all interactive objects.  
   'check bag': can show the exist item in bag.  
   'search object': can search items in a object.  
2. After installing fgl and split, download the Escape_func.hs, Escape_type.hs and main.hs and use GHCi load main.hs. Enter 'main' to open this game. After opening game, enter 'start' to begin this game. User can input 'help' in program to get the introduction of operation. Main acceptable operations contain exit, search, open doors, check bag etc. 
3. question1 : how can we use monad in our structure.   
   question2 : how use haskell to read and write a data file. We want to use this to implement save/load funciton.  
               Now we just set the environment in main. Plan is to set all data in another file. Before game beginning, open this file and                 reload. Saving can save the environment to that file.   
   
Milestones(2):  
-----  
* In this project, our group make several record syntaxs for four types of data which will be used.  
1. Room is the basic unit of this game. It contains several objects to be interactived in this game. Nowadays there are only one room. We consider design several rooms and then use doors to connect rooms.  
2. Objects are interactive elements in this game. There are two kinds of objects. One is common objects. Players can interactive with them to collect items. Another one is doors. Players can interactive with doors to move from roomA to roomB. Objects' imformation will be hidden until they are be unlocked.  
3. Items are the smallest elements in this game. They are all in objects or players' bag.  
4. Player represent palyers' location and what items in palyers' bag.  
* For these above data types, we choose to use functor. For rooms, objects and items, we always need their ids and names. So we design a functor and get_id & get_name functions to run for all these three data types.  
* Following classmates' suggestion, we make several changes. The most important one is that we define all acceptable actions as data Cmd, such as searching room and interactive with objects. This will help us recognize if the input can be an acceptable action.  
* For the expandability, our plan is to add a data type as lock. Objects can be locked by keys or passwords. Now we meet with one problem about one object corresponds to multiple locks. Unlock conditions can be "and"(e.x. Safe needs one key and one password at the same time) and "or"(e.x. DoorA can be unlocked by either Key1 or Key2). We want to find out if functor or something else can help us achieve it.
