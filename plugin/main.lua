local bolt = require('bolt')
local models = require('plugin.models')
local textures = require('plugin.textures')
local helpers = require('plugin.helpers')
local machine = require('plugin.statemachine')
local map = require('plugin.map')
local json = require('plugin.json')

local floorsize = nil

local function findfloorsize(event)
    local i = 1
    while i < event:vertexcount() do
        local brx, bry = event:vertexxy(i)
        local tlx, tly = event:vertexxy(i + 2)
        local blx = tlx
        local bly = bry

        local w = brx - tlx
        local h = bry - tly

        local _, _, _, a = event:vertexcolour(i)

        for floorsize, data in pairs(textures.dungeonmap.background) do
            if w == data.w and h == data.h and math.floor(a * 255) == math.floor(data.a * 255) then
                return {
                    size = floorsize,
                    x = blx,
                    y = bly,
                    w = w,
                    h = h
                }
            end
        end
        i = i + event:verticesperimage(i)
    end
    return nil
end

local function isindungeon(event)
    for i = 1, event:vertexcount() do
        if helpers.iscorrecttexture(event, i, 34, 34, textures.minimap.opendungeonmap.offset, textures.minimap.opendungeonmap.data) then
            return true
        end
    end
    return false
end
















local floormap = nil
local browser = nil
local updated = false

local function senddata()
    if browser == nil or floormap == nil then
        return
    end

    local message = '{ "floorsize": "'..floormap.size..'", "rooms": '..json.encode(floormap.rooms).."}"

    browser:sendmessage(message)
end

local statemachine = machine.create({
    initial = 'notindungeon',
    events = {
        { name = "joineddungeon", from = "notindungeon",                         to = "indungeonfindingmap" },
        { name = "foundmap",      from = "indungeonfindingmap",                  to = "indungeon" },
        { name = "leftdungeon",   from = { "indungeon", "indungeonfindingmap" }, to = "notindungeon" },
        { name = "maphidden",     from = "indungeon",                            to = "indungeonnomap" }
    },
    callbacks = {
        onindungeonnomap = function(self, event, from, to)
            helpers.log("Player entered a dungeon! :^)")
        end,
        onfoundmap = function(self, event, from, to)
            helpers.log("Found the map")

            if floormap == nil then
                return
            end

            local tlx = floormap.bottomleft.x
            local tly = floormap.bottomleft.y - floormap.background.h

            browser = bolt.createembeddedbrowser(tlx, tly, floormap.background.w, floormap.background.h, "plugin://webpage/index.html")
            browser:showdevtools()
        end,
        onleftdungeon = function(self, event, from, to)
            floormap = nil
        end
    }
})

bolt.onrender3d(function(event)
    if statemachine:is("notindungeon") or not event:animated() then
        return
    end

    if statemachine:is("indungeon") and floormap ~= nil then
        local wasupdated = floormap:update3d(event)

        if not updated then
            updated = wasupdated
        end
    end
end)

bolt.onrender2d(function(event)
    local wasupdated = false

    -- Check to see if the player is in a dungeon
    if statemachine:is("notindungeon") and isindungeon(event) then
        statemachine:joineddungeon()
    end

    if statemachine:is("indungeonfindingmap") then
        local floorsize = findfloorsize(event)

        if floorsize ~= nil then
            -- If floormap is not nil it's because the map was hidden. Don't want to replace it in that case
            if floormap == nil then
                floormap = Map:new(floorsize.size, floorsize.x, floorsize.y, floorsize.w, floorsize.h)
            end

            statemachine:foundmap()
        end
    end

    if statemachine:is('indungeon') then
        if floormap ~= nil then
            wasupdated = floormap:update(event)
        end
    end

    if not updated then
        updated = wasupdated
    end
end)

bolt.onswapbuffers(function(event)
    if updated then
        senddata()
        updated = false
    end
end)
