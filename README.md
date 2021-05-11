# Escape

<!-- Instell the packages -->
<!-- It will take many times -->
### Before you run the code you need to install those package.
cabal install fgl  
cabal install split  

<!-- 1. A brief description of your project goals (you can take this from your project proposal), and your current progress toward achieving those goals.
     2. Instructions for how to run your project (e.g. which file to load in GHCi), including several example inputs, if applicable.
     3. In Milestone #1: a list of 2–4 design questions that you have about your project, that you would like to discuss during the workshop.-->

1. This is a graphic room escape decryption game. The user's goal is to escape the room through interaction with map objects.  
   We have build the basic project structure. Based on this structure, we have build the three function:   
   'search room': can show the all interactive objects.  
   'check bag': can show the exist item in bag.  
   'search object'k: can search items in a object.  
2. After user install fgl and split, download the Escape_func.hs, Escape_type.hs and main.hs and use GHCi load main.hs. Enter 'main' to open this game. After opening game, enter 'start' to begin this game. User can input 'help' in program to get the introduction of operation. Main acceptable operations contain exit, search, open doors, check bag etc. 
3. question1 : how can we use monad in our structure.   
   question2 : how use haskell to read a file. We want to use this to implement save/load funciton.  
               Now we just set the environment in main. Plan is to set all data in another file. Before game beginning, open this file and reload. Saving can save the environment to that file.   
   
