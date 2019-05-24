# Ruby Training Tasks

## Monster Fight

### Stage 1

Create CLI game where a Player fights a Monster.  
The game is played in turns.   
Each turn the Player hits the Monster and the the Monster hits the Player.  
The game ends when either Monster's or Players health is <= 0.   
Player starts with 30 health and Monster starts with 25 health.  
Player hits the Monster for a value of his `attack_power` which is a random 
value between 2 and 5.  
Monster hits the player for a value of his `attack_power` which is a random 
value between 1 and 6.  
Each turn at the beginning of the turn player can choose to do normal attack or 
special attack (`attack_power` * 2).  
Player has only 1 special attack.  
When a program is launched a new game is started.  
The player chooses who goes (hits) first: monster or player.  
Each turn the damage of each hit and resuming health are printed to the console 
like this:  
"Player hits monster for 4 damage. Monster has 12 health left"  
When game ends, the result is printed to the console.  
When game ends the player can choose to start the game again.  
The player can exit the game any time by writing "quit".  

Use OOP approaches you've learned to implement this functionality. Try to reuse 
as much code as possible.

### Stage 2

When Player wins he gains 10 experience points.  
When Player looses he looses 8 experience points.  
Player starts with level 1. Max level is 10.  
When Player gains enough experience, he gains a new level.  
Formula for exprience required is the following:  

> 10 * (level ^ 2) - (10 * level)

When player levels up, he can choose one of the two:

- Increase health by 1
- Increase attack power range by 1

As Player gains a level, Monster also gains a level and both his health and
attack power range are increased by 1.  
When Player reaches level 2 he gains a new 'magic' attack type.   
Magic attack type deals damage: `attack_power` * 3.   
When Player reaches level 3 he gains a new 'stun' attack type.  
Stun attack type deals damage equal to `attack_power` but Monster doesn't 
attack this turn if he goes second or next turn if he goes first.  
When Player reaches level 4 he gains a new 'block' attack type. Player doesn't
attack Monster but heals for his `attack_power` * 2.  
Player can use all these attack types only once each.
The Monster also gains all these attack types at corresponding level + 1. So at
level 2 Monster gains special attack and so on.  
Monster also can use all these attack types only once each.  
When Monster hits a player he randomly chooses which attack type to use out of
all that are available.  
At the start of the game it's possible to choose the starting level of a Player.  
If the Player deals higher damage than Monster at least 3 times in a row, 
there's a 50% chance that the Monster runs away and Player wins and gains 
experience proportional to the damage dealt to monster.  
So if the Monster had 30 health at the start and ran away with 15 health, the 
Player gains 10 / 2 experience points.
