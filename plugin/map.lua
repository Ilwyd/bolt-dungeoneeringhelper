local textures = require("plugin.textures")
local helpers = require("plugin.helpers")
local models = require("plugin.models")
local bolt = require("bolt")

Map = {
	rooms = {}, -- Array holding room details
	size = nil, -- Size of the current floor
	bottomleft = { x = 0, y = 0 }, -- Bottom left pixel of the dungeon map
	basetile = { x = -1, z = -1 }, -- The base tile of the south east region of the instance
	playerroom = { x = -1, y = -1 }, -- The player's current room
	background = { w = -1, h = -1 }, -- The width / height of the dungeonmap's background
}
Map.__index = Map

local function generateEmptyMap(x, y)
	local roomgrid = {}
	for xpos = 1, x do
		roomgrid[xpos] = {}

		for ypos = 1, y do
			roomgrid[xpos][ypos] = {}
		end
	end

	return roomgrid
end

local function findcolour(event)
	local r, g, b, _ = event:vertexcolour(0)
	local zerothvertcolour = {
		math.floor(r * 255 + 0.5),
		math.floor(g * 255 + 0.5),
		math.floor(b * 255 + 0.5),
	}

	for colour, data in pairs(models.keydoors.colours) do
		for _, colourdata in ipairs(data.zerothvertcolours) do
			if helpers.dotablesmatch(zerothvertcolour, colourdata) then
				return colour
			end
		end
	end
end

--- Find the type of door for the given event (if any)
--- @param event any The event to be checked for a door type
--- @return { colour: string, shape: string }
local function finddoortype(event)
	local vertexcount = event:vertexcount()
	local mx, my, mz = event:vertexpoint(0):get()
	local zerothvertpos = { mx, my, mz }

	local keyshape = nil
	local colour = nil
	for shape, data in pairs(models.keydoors.shapes) do
		if vertexcount == data.vertcount and helpers.dotablesmatch(zerothvertpos, data.zerothvertpos) then
			keyshape = shape
			colour = findcolour(event)
		end
	end

	return { colour = colour, shape = keyshape }
end

local function getDirection(originx, originz, targetx, targetz)
	local offsetx = targetx - originx
	local offsetz = targetz - originz

	local x = 0
	local y = 0
	if offsetx > offsetz and offsetx > 0 then
		x = 1
	elseif offsetx < offsetz and offsetz > 0 then
		y = 1
	elseif offsetx < offsetz and offsetx < 0 then
		x = -1
	elseif offsetx > offsetz and offsetz < 0 then
		y = -1
	end

	return {
		x = x,
		y = y,
	}
end

local generateMap = {
	small = generateEmptyMap(4, 4),
	medium = generateEmptyMap(4, 8),
	large = generateEmptyMap(8, 8),
}

local sizeDimensions = {
	small = { x = 4, y = 4 },
	medium = { x = 4, y = 8 },
	large = { x = 8, y = 8 },
}

function Map:new(size, x, y, w, h)
	local obj = {}
	setmetatable(obj, Map)

	self.size = size
	self.rooms = generateMap[size]
	self.bottomleft.x = x
	self.bottomleft.y = y
	self.background.w = w
	self.background.h = h

	return obj
end

function Map:toString()
	local outstring = ""
	for x = 1, #self.rooms do
		local rowstring = ""
		for y = 1, #self.rooms[x] do
			if next(self.rooms[x][y]) == nil then
				rowstring = rowstring .. " " .. "x"
			else
				rowstring = rowstring .. " " .. "o"
			end
		end
		rowstring = rowstring .. "\n"
		outstring = outstring .. rowstring
	end
	return outstring
end

function Map:update(event)
	local updatedshape = false

	local i = 1
	while i < event:vertexcount() do
		local x, y = event:vertexxy(i)
		local xoffset = x - self.bottomleft.x
		local yoffset = y - self.bottomleft.y

		local mapx = math.floor(xoffset / 32)
		local mapy = math.abs(math.floor(yoffset / 32))

		-- Updating the map table with the shape of the room (if any)
		for name, data in pairs(textures.dungeonmap.rooms) do
			local isroomtexture = helpers.iscorrecttexture(event, i, data.w, data.h, data.offset, data.data)
			if isroomtexture and self.rooms[mapx][mapy].roomshape ~= name then
				self.rooms[mapx][mapy].roomshape = name
				updatedshape = true
			end
		end

		-- Setting the player's room based on the map if basetile hasn't been found yet, otherwise use player position
		local playericon = textures.dungeonmap.icons.player1
		local isplayericon =
			helpers.iscorrecttexture(event, i, playericon.w, playericon.h, playericon.offset, playericon.data)
		if isplayericon then
			self.playerroom = { x = mapx + 1, y = mapy }
		end

		i = i + event:verticesperimage(i)
	end

	if self.basetile.x == -1 and self.playerroom.x ~= -1 then
		self:setRegionBase()
	end

	return updatedshape
end

function Map:update3d(event)
	local keysupdated = false
	local gatestoneupdated = false

	if event:animated() then
		keysupdated = self:setRoomKeys(event)
	else
		gatestoneupdated = self:setGatestone(event)
	end

	return keysupdated or gatestoneupdated
end

function Map:setRoomKeys(event)
	local doortype = finddoortype(event)

	if doortype.colour == nil or doortype.shape == nil then
		return false
	end

	local modelpoint = event:vertexpoint(1)
	local worldpoint = modelpoint:transform(event:modelmatrix())
	local x, _, z = worldpoint:get()
	x = math.floor(x / 512)
	z = math.floor(z / 512)

	local roomcoords = self:getRoom(x, z)
	local roomcentercoords = self:getRoomCenter(roomcoords.x, roomcoords.y)

	local doordirectionfromcenter = getDirection(roomcentercoords.x, roomcentercoords.z, x, z)
	local lockedroomcoords =
		{ x = roomcoords.x + doordirectionfromcenter.x, y = roomcoords.y + doordirectionfromcenter.y }
	local key = doortype.colour .. "" .. doortype.shape

	if self.rooms[lockedroomcoords.x][lockedroomcoords.y].key ~= key then
		self.rooms[lockedroomcoords.x][lockedroomcoords.y].key = key
		return true
	end

	return false
end

function Map:setGatestone(event)
	local vertexcount = event:vertexcount()
	local modelpoint = event:vertexpoint(0)

	local mx, my, mz = event:vertexpoint(0):get()
	local zerothvertpos = { mx, my, mz }

	local r, g, b, _ = event:vertexcolour(0)
	local zerothvertcolour = {
		math.floor(r * 255 + 0.5),
		math.floor(g * 255 + 0.5),
		math.floor(b * 255 + 0.5),
	}

	for gatestone, data in pairs(models.gatestones) do
		local samevertcount = vertexcount == data.vertcount
		local samezerothvertpos = helpers.dotablesmatch(zerothvertpos, data.zerothvertpos)
		local samecolour = helpers.dotablesmatch(zerothvertcolour, data.zerothvertcolour)

		if samecolour or samevertcount or samezerothvertpos then
			print(vertexcount, data.vertcount)
			print(table.concat(zerothvertpos, "|"), table.concat(data.zerothvertpos, "|"))
			print(table.concat(zerothvertcolour, "|"), table.concat(data.zerothvertcolour, "|"))
			print()
		end

		if samecolour and samevertcount and samezerothvertpos then
			local worldpoint = modelpoint:transform(event:modelmatrix())
			local x, _, z = worldpoint:get()
			x = math.floor(x / 512)
			z = math.floor(z / 512)
			local roomcoords = self:getRoom(x, z)

			self:clearGatestone(gatestone)
			self.rooms[roomcoords.x][roomcoords.y].gatestone = gatestone

			return true
		end
	end

	return false
end

function Map:clearGatestone(gatestone)
	for x = 1, #self.rooms do
		for y = 1, #self.rooms[x] do
			if self.rooms[x][y].gatestone == gatestone then
				self.rooms[x][y].gatestone = nil
			end
		end
	end
end

-- Get a room based on the world x and z coords
function Map:getRoom(worldx, worldz)
	local instancex = worldx - self.basetile.x
	local instancez = worldz - self.basetile.z

	local out = {
		x = math.floor(instancex / 16) + 1,
		y = math.floor(instancez / 16) + 1,
	}

	return out
end

-- Setting the Map.basetile. This is the base tile of the bottom left region of the dungeoneering instance
function Map:setRegionBase()
	local px, _, pz = bolt.playerposition():get()
	px = px / 512
	pz = pz / 512

	-- Base tile of the player's current region.
	local currRegionBase = {
		x = px - (px % 64),
		z = pz - (pz % 64),
	}

	-- Setting the player's region offset from the base region
	local regionOffsetX = math.floor((self.playerroom.x - 1) / 4)
	local regionOffsetZ = math.floor((self.playerroom.y - 1) / 4)

	self.basetile = {
		x = currRegionBase.x - (regionOffsetX * 64),
		z = currRegionBase.z - (regionOffsetZ * 64),
	}
end

function Map:getRoomCenter(x, y)
	return {
		x = self.basetile.x + (x - 1) * 16 + 8,
		z = self.basetile.z + (y - 1) * 16 + 8,
	}
end
