local function iscorrecttexture(event, index, w, h, offset, data)
	local ax, ay, aw, ah = event:vertexatlasdetails(index)
	if aw == w and ah == h and event:texturecompare(ax, ay + offset, data) then
		return true
	end

	return false
end

local function tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

local function iscolourinrange(colour, colourrange)
	local inrrange = colour.r >= colourrange.r[1] and colour.r <= colourrange.r[2]
	local ingrange = colour.g >= colourrange.g[1] and colour.g <= colourrange.g[2]
	local inbrange = colour.b >= colourrange.b[1] and colour.b <= colourrange.b[2]
	local incolourrange = inrrange and ingrange and inbrange

	return incolourrange
end

return {
	iscorrecttexture = iscorrecttexture,
	tprint = tprint,
	iscolourinrange = iscolourinrange,
}
