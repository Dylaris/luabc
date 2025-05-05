local LUABC_DIR = "../../"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool
local debug = luabc.debug

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = (luabc.os == "UNIX") and "helloworld" or "helloworld.exe"
local SRC    = tool.match_file_extension(".c")
local OBJ    = (luabc.os == "UNIX") and tool.replace_files_extension(SRC, ".o") or tool.replace_files_extension(SRC, ".obj")
local CLEAR_FILES = { TARGET, table.unpack(OBJ) }

-- usage: lua build.lua [-clean][-all]

local function build()
    -- execute the commands in ascending order
    -- cmd:new(label, order)
    for i = 1, #SRC do
        local compile = cmd:new("all")
        compile:append(CC, CFLAGS, CSTD, "-c", "-o", OBJ[i], SRC[i])
    end

    local link = cmd:new("all")
    link:append(CC, CFLAGS, CSTD, "-o", TARGET, OBJ)

    local clean = cmd:new("clean")
    -- clean:append("rm -rf", CLEAR_FILES)  -- run the command
    clean:call(tool.clean, CLEAR_FILES)     -- run the function
end

build()     -- ready for building

luabc.build()
