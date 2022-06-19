--[[
main file

right now, the goal is just to establish a grid of tiles that you can interact with.
]]

Class = require 'class'

require 'Sprite'
require 'Layer'

--[[
Here, I specify regions in terms of total dimensions, where each region
has a specific tile sprite. Note this is only where x E[0,n-1] and y E[0,m-1]
]]
function getTileSprite(x, y, n, m)
    if (x==0 or x==n-1 or y==0 or y==m-1) then
        return Sprite(edge,x*p,y*p)
    end
    if (x>1 and x<n/2-1) and (y>1 and y<m-2) then
        return Sprite(shop,x*p,y*p)
    end
    if (x>n/2 and x<n-2) and (y>1 and y<m-2) then
        return Sprite(board,x*p,y*p)
    end
    return Sprite(background,x*p,y*p)
end

--[[
override love.load, this loads the window
]]
function love.load()
    love.window.setTitle('Magical Automata')
    n=35 -- width (in # of tiles)
    m=21 -- height (in # of tiles)
    p=32 -- pixels per tile
    love.window.setMode(n*p, m*p, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- make all intended layers I used layers 0, 1, and 2 here
    -- these will be the background, interactable objects, and mouse highlights
    layers = {}
    for i=0,3 do
        layers[i] = Layer(n, m, p, {}, {}, {})
    end

    -- here, I establish global vars for all the sprites.
    -- using this, I make all the layers
    -- the background layer starts populated and displayed
    -- the interactable objects layer starts with nothing to display
    -- the highlight layer starts with sprites, but doesn't display anything
    board = 'images/board_tile.png'
    shop = 'images/shop_tile.png'
    background = 'images/bgnd_tile.png'
    edge = 'images/edge_tile.png'
    highlight = 'images/highlight_tile.png'

    for r=0,m-1 do
        tmp0g = {}
        tmp0b = {}
        tmp1g = {}
        tmp1b = {}
        tmp2g = {}
        tmp2b = {}
        for c=0,n-1 do
            x = c * p
            y = r * p
            tmp0g[c] = getTileSprite(c, r, n, m)
            tmp0b[c] = true
            tmp1g[c] = nil
            tmp1b[c] = false
            tmp2g[c] = Sprite(highlight, x, y)
            tmp2b[c] = false
        end
        layers[0].gvis[r] = tmp0g
        layers[0].bvis[r] = tmp0b
        layers[1].gvis[r] = tmp1g
        layers[1].bvis[r] = tmp1b
        layers[2].gvis[r] = tmp2g
        layers[2].bvis[r] = tmp2b
    end

end

debounce = false

function love.draw()
    -- decide what to render:
    local x, y = love.mouse.getPosition()
    if love.mouse.isDown(1) and debounce == false then
        layers[2].bvis[math.floor(y/p)][math.floor(x/p)] = not layers[2].bvis[math.floor(y/p)][math.floor(x/p)]
        debounce = true
    end
    if not love.mouse.isDown(1) then
        debounce = false
    end
    -- finally, render everything
    for k in pairs(layers) do
        for j in pairs(layers[k].gvis) do
            for h in pairs(layers[k].gvis[j]) do
                if layers[k].bvis[j][h] then
                    layers[k].gvis[j][h]:render()
                end
            end
        end
    end
end
