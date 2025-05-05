local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool
local debug = luabc.debug

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = (luabc.os == "UNIX") and "zero" or "zero.exe"
local SRC    = tool.match_file_extension(".c")
local LD_LIB = ""

local function build()
    debug.log.info[[

    If you want to use 'zero', make sure to set the correct 'CFLAGS' and 'LD_LIB':
    Use '-I' to specify the path to the Lua header files.
    Use '-L' to specify the location of the dynamic library.
    Use '-l' to specify the name of the library to link.
    ]]

    -- NOTE <<< update here >>>
    if luabc.os == "WIN" then
        table.insert(CFLAGS, "-I../lua53/src")
        LD_LIB = "-L.. -llua53"
    else
        LD_LIB = "-llua5.4"
    end

    local all = cmd:new()
    all:append(CC, CFLAGS, CSTD, "-o", TARGET, SRC, LD_LIB)
    all:run()
end
build()
