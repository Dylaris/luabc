local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool
local debug = luabc.debug

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = "zero"
local SRC    = tool.match_file_extension(".c")
local LD_LIB = "-llua5.4"

local function build()
    local all = cmd:new()
    all:append(CC, CFLAGS, CSTD, "-o", TARGET, SRC, LD_LIB)
    all:run()
end
build()
