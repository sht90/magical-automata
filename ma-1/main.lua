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
    local x, y = love.mouse.getPosition()
    if love.mouse.isDown(1) and debounce == false then
        selected[math.floor(y/p)][math.floor(x/p)] = not selected[math.floor(y/p)][math.floor(x/p)]
        debounce = true
    end
    if not love.mouse.isDown(1) then
        debounce = false
    end
end
