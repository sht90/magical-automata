--[[
Layer class. Hopefully useful in future programs.

Each layer is going to just be a list of sprites, or of cells, or something like that.

Each layer will have:
a "2D array" of sprites
a "2D array" of corresponding game objects
a "2D array" of booleans, indicating whether the cells will be displayed
a "2D array" of booleans, indicating whether the game objects will respond to input
]]

Layer = Class{}

function Layer:init(n, m, p, gridVisuals, gridActions, gridVisibility, gridActionability)
    self.n = n
    self.m = m
    self.p = p
    self.gvis = gridVisuals
    self.gact = gridActions
    self.bvis = gridVisibility
    self.bact = gridActionability
end
