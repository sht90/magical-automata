--[[
Unit class

finally, making a class for units
this will need to account for game state, eventually. For now, it's just something that takes up a 3x3 square on a board composed of 1x1 squares.
]]

Unit = Class{}

function Unit:init(width, height, sprite)
    self.width = width
    self.height = height
    self.sprite = sprite
    self.x = sprite.x
    self.y = sprite.y
end

function Unit:isInBounds(x, y, p)
    return ((math.floor(self.x/p) + self.width) > x) and (math.floor(self.x/p) <= x) and (math.floor(self.y/p) + self.height > y) and (math.floor(self.y/p) <= y)
end

function Unit:render(x, y)
    return self.sprite:render(x, y)
end
