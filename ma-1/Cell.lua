--[[
Cell class, which I can hopefully use in future programs

Displaying cells on a grid without a cell class isn't too bad -- I can just render sprites in necessary order. However, when I want to click on an object and find out the consequences of that click... hoo boy. Now I need a class to manage what's actually happening in each cell.
]]

Cell = Class{}

function Cell:init(x, y, p, hovered_behavior, clicked_behavior)
    self.x = x
    self.y = y
    self.p = p
    self.on_hover = hovered_behavior
    self.on_click = clicked_behavior
    self.render = rendered_behavior
end
