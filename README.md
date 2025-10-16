# Siege Week 3 -> Name TBD
The game I'm making for Hackclub's Siege; The theme this week was Signal.

I'm thinking an arcade game where you have to collect transmitters in the dark?

## Devlogs
### Monday -> Setup
- Imported the framework, got rid of all the unnecessary fluff.
- Planned out what I want to make, for the most part - I'm taking this week a lot less seriously because I'm doing Milkyway too.
### Tuesday -> Basic Game Mechanics
- Got a lot done this week, namely the base game mechanics are mostly done;
    - Transmitters can be picked up and tracked
    - Enemies can attack you and be tracked
- The spawners for enemies/transmitters are... in their beginning stages
- There's no lose condition yet, or UI for that matter.
### Wednesday -> Spawners
- I got the spawners working as I want them, and not much else...
### Thurday -> MVP
- The UI is done, just a basic start screen and lose screen.
- Losing is done, it's literally just running the losescreen animation when the health hits zero
- I've got the shader set up, though I'm definitely going to play with the effect a bit
    - Can't decide whether to do full grayscale, some lerp between color and grayscale, or what...
- I changed how the Enemies follow the player to be a big dash, then they slide along in that direction for a bit. I... might make some silly animation for it, we'll see