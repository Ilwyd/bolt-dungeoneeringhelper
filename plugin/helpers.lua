local bolt = require('bolt')

local function iscorrecttexture(event, index, w, h, offset, data)
    local ax, ay, aw, ah = event:vertexatlasdetails(index)
    if aw == w and ah == h and event:texturecompare(ax, ay + offset, data) then
        return true
    end
end

local function log(msg)
    local year, month, day, hour, minute, second = bolt.datetime()

    print(
        string.format("[%s:%s:%s]", tostring(hour), tostring(minute), tostring(second))
        ..msg
    )
end

local function dotablesmatch(table1, table2)
    if table.concat(table1) == table.concat(table2) then
        return true
    end

    return false
end

local function tprint (tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2 
    for k, v in pairs(tbl) do
      toprint = toprint .. string.rep(" ", indent)
      if (type(k) == "number") then
        toprint = toprint .. "[" .. k .. "] = "
      elseif (type(k) == "string") then
        toprint = toprint  .. k ..  "= "   
      end
      if (type(v) == "number") then
        toprint = toprint .. v .. ",\r\n"
      elseif (type(v) == "string") then
        toprint = toprint .. "\"" .. v .. "\",\r\n"
      elseif (type(v) == "table") then
        toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
      else
        toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
      end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    return toprint
  end
  

return {
    iscorrecttexture = iscorrecttexture,
    log = log,
    dotablesmatch = dotablesmatch,
    tprint = tprint
}
