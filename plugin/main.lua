local bolt = require("bolt")
local textures = require("plugin.textures")
local helpers = require("plugin.helpers")
local machine = require("modules.statemachine")
local map = require("plugin.map")
local json = require("modules.json")
local log = require("plugin.logger").log

local floormap = nil
local browser = nil
local updated = false
local isplayerindungeon = false
local prevbasetile = {
	x = -1,
	z = -1,
}

--- Find the floorsize from the given Batch2D event, if any
--- @param event any The Batch2D event to be checked for the floorsize
--- @return { size: string, x: integer, y: integer, w: integer, h: integer } | nil
local function findfloorsize(event)
	local i = 1
	while i < event:vertexcount() do
		-- Get the x and y coords of the bottom right and top left vertices
		local brx, bry = event:vertexxy(i)
		local tlx, tly = event:vertexxy(i + 2)

		-- Get the bottom left x and y coords based off of the above
		local blx = tlx
		local bly = bry

		-- Derive the width and height of the texture
		local w = brx - tlx
		local h = bry - tly

		local _, _, _, a = event:vertexcolour(i)

		-- Loop through the data we have on each floorsize (width, height, alpha of the dungeoneering map's background)
		for floorsize, data in pairs(textures.dungeonmap.background) do
			if w == data.w and h == data.h and math.floor(a * 255) == math.floor(data.a * 255) then
				return {
					size = floorsize,
					x = blx,
					y = bly,
					w = w,
					h = h,
				}
			end
		end
		i = i + event:verticesperimage(i)
	end
	return nil
end

--- Checks to see if the player is in the dungeon by attempting to find the dungeoneering map button on the minimap
--- @param event any The event to be checked for the dungeoneering map button
--- @return boolean
local function isindungeon(event)
	for i = 1, event:vertexcount() do
		if
			helpers.iscorrecttexture(
				event,
				i,
				34,
				34,
				textures.minimap.opendungeonmap.offset,
				textures.minimap.opendungeonmap.data
			)
		then
			return true
		end
	end
	return false
end

--- Converts floor data to a JSON string and sends it to the browser to be displayed on the map
local function senddata()
	if browser == nil or floormap == nil then
		return
	end

	log(json.encode(floormap.rooms))

	local message = "{"
		.. '"floorsize": "'
		.. floormap.size
		.. '", '
		.. '"rooms": '
		.. json.encode(floormap.rooms)
		.. ", "
		.. '"heldkeys": '
		.. json.encode(floormap.heldkeys)
		.. "}"

	browser:sendmessage(message)
end

local statemachine = machine.create({
	initial = "notindungeon",
	events = {
		{ name = "joineddungeon", from = "notindungeon", to = "indungeonfindingmap" },
		{ name = "foundmap", from = "indungeonfindingmap", to = "indungeon" },
		{ name = "leftdungeon", from = { "indungeon", "indungeonfindingmap" }, to = "notindungeon" },
		{ name = "maphidden", from = "indungeon", to = "indungeonfindingmap" },
	},
	callbacks = {
		onstatechange = function(self, event, from, to)
			log("State changed from " .. from .. " to " .. to)
		end,

		onindungeonnomap = function(self, event, from, to) end,

		-- When the map is found on the player's screen:
		-- Set up the browser on top of the in-game dungeon map
		onfoundmap = function(self, event, from, to)
			if floormap == nil then
				return
			end

			local tlx = floormap.bottomleft.x
			local tly = floormap.bottomleft.y - floormap.background.h

			browser = bolt.createembeddedbrowser(
				tlx,
				tly,
				floormap.background.w,
				floormap.background.h,
				"plugin://webpage/index.html"
			)
			-- browser:showdevtools()
		end,

		-- When the player leaves the dungeon:
		-- Set the floormap to nil
		-- Get rid of the browser overlay on the map
		onleftdungeon = function(self, event, from, to)
			if floormap ~= nil then
				prevbasetile = floormap.basetile
			end
			floormap = nil

			if browser ~= nil then
				browser:close()
				browser = nil
			end
		end,
	},
})

bolt.onrendericon(function(event)
	if statemachine:is("indungeon") and floormap ~= nil then
		local wasupdated = floormap:updateicon(event)

		if not updated then
			updated = wasupdated
		end
	end
end)

bolt.onrender3d(function(event)
	if statemachine:is("notindungeon") then
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

	if not isplayerindungeon then
		isplayerindungeon = isindungeon(event)
	end

	-- Check to see if the player is in a dungeon
	if statemachine:is("notindungeon") and isplayerindungeon then
		statemachine:joineddungeon()
	end

	if statemachine:is("indungeonfindingmap") then
		local floorsize = findfloorsize(event)

		if floorsize ~= nil then
			-- If floormap is not nil it's because the map was hidden. Don't want to replace it in that case
			if floormap == nil then
				floormap = Map:new(floorsize.size, floorsize.x, floorsize.y, floorsize.w, floorsize.h, prevbasetile)
			end

			statemachine:foundmap()
		end
	end

	if statemachine:is("indungeon") then
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

	if not isplayerindungeon and (statemachine:is("indungeon") or statemachine:is("indungeonfindingmap")) then
		statemachine:leftdungeon()
	end

	isplayerindungeon = false
end)
