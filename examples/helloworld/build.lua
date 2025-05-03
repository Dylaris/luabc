local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool
local debug = luabc.debug

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = "helloworld"
local SRC    = tool.match_file_extension(".c")
local OBJ    = tool.replace_files_extension(SRC, ".o")
local CLEAR_FILES = { TARGET, table.unpack(OBJ) }

-- usage: lua build.lua

local function build()
    local all = cmd:new()
    all:append(CC, CFLAGS, CSTD, "-o", TARGET, SRC)
    all:run()
end
build()
