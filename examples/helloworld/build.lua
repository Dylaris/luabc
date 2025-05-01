local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = "helloworld"
local SRC    = tool.match_file_extension("c")
local OBJ    = (function () 
    local res = {}
    for _, file in ipairs(SRC) do
        table.insert(res, tool.replace_file_extension(file, "o"))
    end
    return res
end)()
local CLEAR_FILES = { TARGET, table.unpack(OBJ) }

-- directly run the command
-- usage: lua build.lua
--[[ 
local function build()
    local cmd = cmd:new()
    cmd:append(CC, CFLAGS, CSTD, "-o", TARGET, SRC)
    cmd:run()
    -- tool.clean(CLEAR_FILES)
end
build()
--]]

-- use label and bind
-- usage: lua build.lua [-clean][-all]
---[[ 
local function build()
    -- execute the commands in ascending order
    -- cmd:new(label, order)
    for i = 1, #SRC do
        local compile = cmd:new("all", i)
        compile:append(CC, CFLAGS, CSTD, "-c", "-o", OBJ[i], SRC[i])
    end

    local link = cmd:new("all", #SRC+1)
    link:append(CC, CFLAGS, CSTD, "-o", TARGET, OBJ)

    local clean = cmd:new("clean", 1)
    clean:append("rm -rf", CLEAR_FILES)

    luabc.build()
end
build()
--]]
