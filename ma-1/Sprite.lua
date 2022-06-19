--[[
Sprite class, which I can hopefully use in future programs.

In this generic form, right now the only things I can foresee using are:
init (parameters)
    the name of the image
    the image itself
    the x and y coordinates of where to put the image
    the width and height of the image, in pixels
render()
    and of course the ability to display the sprite on the screen.
]]

Sprite = Class{}

function Sprite:init(name, x, y)
    self.name = name
    self.img = love.graphics.newImage(name)
    self.x = x
    self.y = y
    --self.width = self.img.getPixelWidth()
    --self.height = self.img.getPixelHeight()
end

function Sprite:render(x, y)
    if x == nil then x = self.x end
    if y == nil then y = self.y end
    love.graphics.draw(self.img, x, y)
end
