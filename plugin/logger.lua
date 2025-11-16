local bolt = require("bolt")

local function log(msg)
	local _, _, _, hour, minute, second = bolt.datetime()

	print(string.format("[%02d:%02d:%02d]", tostring(hour), tostring(minute), tostring(second)) .. " " .. msg)
end

return {
	log = log,
}
