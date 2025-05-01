local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")

local cmd = luabc.cmd
local tool = luabc.tool

local c1 = cmd:new("print", 2)
local c2 = cmd:new("print", 1)

c1:append("echo", "second")
c2:append("echo", "first")

luabc.build()
