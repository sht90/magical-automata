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

function getUnitSprite(x, y, n, m)
    if (x == 4 and y == 5) then
        return Sprite(unit1, x*p, y*p)
    end
    if (x == 9 and y == 6) then
        return Sprite(unit2, x*p, y*p)
    end
    return nil
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
    -- TODO
    -- make one more layer for valid areas to put an object. Let them be red+translucent so that I can tell what they look like in some hypothetical debugging mode, but leave their visibility on false in all standard applications.
    -- and I guess make another layer, still, for displaying that an intended placement is invalid.
    numLayers = 4
    layers = {}
    for i=0,numLayers do
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
    red_highlight = 'images/red_highlight.png'
    unit1 = 'images/unit1.png'
    unit2 = 'images/unit2_2.png'
    unit3 = 'images/unit3.png'

    tmpb = {}
    tmpg = {}
    for r=0,m-1 do
        for i=0,numLayers do
            tmpg[i] = {}
            tmpb[i] = {}
        end
        for c=0,n-1 do
            x = c * p
            y = r * p
            tmpg[0][c] = getTileSprite(c, r, n, m)
            tmpb[0][c] = true
            tmpg[1][c] = getUnitSprite(c, r, n, m)
            tmpb[1][c] = ((not (tmpg[1][c] == nil)) or (c-1>=0 and (not (tmpg[1][c-1] == nil))) or (c-2>=0 and (not (tmpg[1][c-2] == nil))) or (r-1>=0 and (not (layers[1].gvis[r-1][c] == nil))) or (r-2>=0 and (not (layers[1].gvis[r-2][c] == nil))))
            tmpg[2][c] = Sprite(highlight, x, y)
            tmpb[2][c] = false
            tmpg[3][c] = Sprite(red_highlight, x, y)
            tmpb[3][c] = false
        end
        for i=0,numLayers do
            layers[i].gvis[r] = tmpg[i]
            layers[i].bvis[r] = tmpb[i]
        end
    end
end

debounce = false

function love.draw()
    -- decide what to render:
    local x, y = love.mouse.getPosition()
    local r = math.floor(y/p)
    local c = math.floor(x/p)
    --[[if love.mouse.isDown(1) and debounce == false then
        layers[2].bvis[math.floor(y/p)][math.floor(x/p)] = not layers[2].bvis[math.floor(y/p)][math.floor(x/p)]
        debounce = true
    end
    if not love.mouse.isDown(1) then
        debounce = false
    end]]
    --if layers[1].gvis[r][c] != nil or layers[1].gvis[r][c]

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
