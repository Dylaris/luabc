local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")

local cmd = luabc.cmd
local tool = luabc.tool

-- cmd:append("gcc", "-o", "main", "main.c")
-- cmd:print()

local res, _ = tool.match_file_extension("lua")
for key, val in ipairs(res) do
    val = tool.replace_file_extension(nil, "c")
    print(key, val)
end
