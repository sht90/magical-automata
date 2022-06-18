# Notes

## Preface

Okay. I've written a lot about magical automata, and I need to stop myself. This time's different though -- these notes aren't me proposing cool game ideas (or, well... maybe they will be, but only in the probably-not-that-near future). Instead, this is like... a proper dev log. Or at least, I think that's what "dev log" usually means, ha!

## Magical Automata

So the main mechanical premise of this game is to explore the middle ground between a card game and an autobattler -- it'll have a shop phase like an autobattler, but scorekeeping/life and deckbuilding will be comparable to ordinary turn-based card games.

Automata is a generic way to describe an autobattler unit, and "magic" is a thematic catch-all. Basically everything at this stage is subject to change, though in other documents I've done a bit of theming and kind of like it.

Magical Automata will be the working name of this game, and at the very least will be the name of this folder. Much in the style of the CS50 lectures, every update I produce will be number sequentially: ma-0, ma-1, etc. This will also serve a bit like version control, even though of course I'll back this up on github too.

Also, note that the easiest way to run this is probably:

```
/Applications/love.app/Contents/MacOS/love isotric_grid/
```

## MA-0

At this stage, I'm not going to focus on getting every single "intended" or "promised" feature yet -- frankly, not even close.

I think the first feature that I'll implement is the autobattler style shop. Soon after, I intend to implement things like the button that changes phase from the shop to the autobattle. Also in the future, I want autobattler units to be scattered about slightly randomly, for a somewhat organic look. However, for now I'm more than content to give them a pre-assigned location.

### Autobattler Style Shop

~~Commonly referred to, of course, as the A.S.S.~~

This has a few notable components:
* a shop
  * a shop is basically just a collection of purchase-able items
  * the cost of each purchase-able item should be clearly displayed
* units
  * a type of purchase-able item. For now, just an arbitrary sprite
* ~~upgrades~~
  * ~~don't worry about these yet~~
* an indicator for how much money you have available to you
  * as you spend money, this should adjust dynamically
* a roll button
  * this should refresh the units in the shop with a random set of other units
* a team
  * when you purchase a unit, this is where it will go
* an end turn button
  * a button that ends the turn. Normally this would switch to another phase of the game -- in this instance, it should probably adjust a state variable, but the new state should just quit the game.
* life
  * you should be able to see how much life you have. Probably also how much life your opponent has, tbh.

My personal vision was for the shop to be very fluid with the board. I want you to be able to drag-and-drop objects -- or, if not drag-and-drop them, have a very controlled way of moving them about the grid (for example, like the arrows pointing from location to destination in Super Auto Pets).

I think a relatively easy implementation of this would be to present the board as a 2D grid. Rather than dragging and dropping the items directly, **clicking an item highlights it** and moving the mouse selects tiles on the screen to show where the new unit will be moved to, with an arrow bridging the current item and the destination. Clicking a valid destination warps the item to that destination, clicking an invalid destination de-selects the item.

As I'm writing this, it's occurring to me that the logic for selection, deselection, highlighting, moving... that's pretty complicated. If I were to break this into chunks (which, I'll see how it goes), I'd:

1. make a grid display with different tiles (ex. shop tiles are not the same as board/team tiles, are not the same as frame/background tiles)
  * trivially, this step itself requires making a tile class, and then a bunch of child classes. I feel like there should be a way to use inheritance in lua, but even if there isn't, it's not a huge deal -- I can copy paste.
2. make a simple selection
  * this would highlight an item -- alter its sprite/appearance somehow
  * this could just be a simple toggle. Click an item to highlight it, click it again to unhighlight it.

I think that's an appropriate first demo. If I get excited and want to progress, I can add to this. For now, it's bedtime!

## MA-1

Whoa! I almost didn't expect it to happen, but I actually satisfied the goals I set for myself for MA-0. I made a scene with different types of tiles, and I made it so that you could select a tile and deselect the same tile, to toggle whether it would be highlighted or not. So... what's next?

In pursuit of an autobattler-style shop, I should make... well, first thing I think I need to make is a Cell class. Each cell right now has a decent amount of metadata. There's a value in grid which supports each sprite, a value in selections which has another sprite for another layer, and selected, which is metadata.

I think a cell should contain a list of sprites, in layer order. So the lowest layer is going to be the background tiles, the highest layer is going to be the highlight tile (presumably -- at least at this stage of the game), and maybe a middle layer would contain things like the units that you'd buy and sell with the shop.
A cell should also have metadata for other fields, including whether it's selected.

I'll also need to make a little more pixel art, but honestly, I've been enjoying making the pixel art, it's fun.

So I think my agenda for MA-1 is:
* introduce "units". Let them occupy a 3x3 grid of cells (or 96x96 pixels)
* make it so that you can select units by clicking on them, and then deselect them by clicking again.
* upon selection of a unit, highlight an area the side of that unit's silhouette, and move it around with the mouse.
* upon deselection of a unit, warp the unit to the area of the preview silhouette. This is how you'll move units.

Having a fuller set of shop features and tracking all of that data / metadata... that'll have to wait till MA-2. I think this'll be an easier update though, hopefully it doesn't take long.

### Day 2

Okay, sudden realization that I got after my initial implementation attempt. I don't really want a cell with a list of sprites in layer order, I want to have layers, contained in order in a list themselves, where each layer functions like how "grid" basically does now.
