--[[
main file

right now, the goal is just to establish a grid of tiles that you can interact with.
]]

Class = require 'class'

require 'Sprite'

-- where x E[0,n-1] and y E[0,m-1]
function getTileSprite(x, y, n, m)
    --print("hey, got a new tile",x,", ",y)
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

function love.load()
    love.window.setTitle('Magical Automata')
    --[[
    in the horizontal direction, there'll be 5 border tiles
    vertical, there'll be 4 border tiles.
    the width of the board should be equal to the width of the shop
    the board should be at least as tall as it is wide (y>x)
    the shop should start at the top left, and leave room for gold & lives.
    What do I think is a good board size, that's condusive to yknow... good strategic thinking?
    The number 17x15 just keeps coming into my head. If I don't like it, I can change it.
    This constrains n to be 15 + 15 + 5 = 35. And m is 17 + 4 = 21.
    Okay... that was dumb moving numbers around, but for now... I actually quite like the result.
    ]]
    n=35
    m=21
    p=32
    love.window.setMode(n*p, m*p, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    grid = {}
    selections = {}
    selected = {}

    board = 'images/board_tile.png'
    shop = 'images/shop_tile.png'
    background = 'images/bgnd_tile.png'
    edge = 'images/edge_tile.png'
    highlight = 'images/highlight_tile.png'

    for r=0,m-1 do
        tmp = {}
        tmp2 = {}
        tmp3 = {}
        for c=0,n-1 do
            x = c * p
            y = r * p
            tmp[c] = getTileSprite(c, r, n, m)
            tmp2[c] = Sprite(highlight, x, y)
            tmp3[c] = false
        end
        grid[r] = tmp
        selections[r] = tmp2
        selected[r] = tmp3
    end

end

debounce = false

function love.draw()
    --print(debounce)
    -- layer 1: establish the grid
    for k in pairs(grid) do
        for j in pairs(grid[k]) do
            grid[k][j]:render()
            if selected[k][j] then
                selections[k][j]:render()
            end
        end
    end
    -- layer 2: establish higlighted entities.
    local x, y = love.mouse.getPosition() -- get the position of the mouse
    if love.mouse.isDown(1) and debounce == false then
        selected[math.floor(y/p)][math.floor(x/p)] = not selected[math.floor(y/p)][math.floor(x/p)]
        debounce = true
    end
    if not love.mouse.isDown(1) then
        debounce = false
    end
    --hoverer = Sprite(highlight,math.floor(x/p)*p,math.floor(y/p)*p)
    --hoverer:render()
end
