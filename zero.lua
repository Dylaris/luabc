local build_file_template = [[
local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"
package.path = package.path .. ";" .. LUABC_DIR .. "?.lua"

local luabc = require("luabc")
local cmd   = luabc.cmd
local tool  = luabc.tool
local debug = luabc.debug

local CC     = "gcc"
local CFLAGS = { "-Wall", "-Wextra" }
local CSTD   = "-std=c11"
local TARGET = "main"
local SRC    = tool.match_file_extension("c", "src")
local OBJ    = tool.replace_files_extension(SRC, "o")
local LD_LIB = ""
local CLEAR  = { TARGET, table.unpack(OBJ) }

local function build()
    local all = cmd:new()
    all:append(CC, CFLAGS, CSTD, "-o", TARGET, SRC)
    all:run()
end
build()
]]

local LICENSE = [[
The MIT License (MIT)
Copyright © 2025 <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local helloworld = [[
#include <stdio.h>

int main(void)
{
    printf("hello world\n");
    return 0;
}
]]

local function zero()
    local LUABC_DIR = os.getenv("HOME") .. "/fun/luabc/"

    local init = function (project) 
        -- create directory
        os.execute("mkdir -p " ..
                   project .. "/src " ..
                   project .. "/test " ..
                   project .. "/examples") 
        -- create file
        os.execute("cd " .. project .. " && " .. 
                   "touch build.lua README.md LICENSE .gitignore src/main.c")
        -- init git
        os.execute("cd " .. project .. " && git init");

        -- init luabc.lua
        os.execute("cd " .. project .. " && cp " .. LUABC_DIR .. "luabc.lua .")
        -- init build.lua
        local file = assert(io.open(project .. "/build.lua", "w"))
        file:write(build_file_template)
        file:close()
        -- init LICENSE
        file = assert(io.open(project .. "/LICENSE", "w"))
        file:write(LICENSE)
        file:close()
        -- init README.md
        file = assert(io.open(project .. "/README.md", "w"))
        file:write("# " .. project)
        file:close()
        -- init src/main.c
        file = assert(io.open(project .. "/src/main.c", "w"))
        file:write(helloworld)
        file:close()
    end

    local update = function () 
        os.execute("cp " .. LUABC_DIR .. "luabc.lua .")
        os.execute("cp " .. LUABC_DIR .. "zero.lua ~/dotfiles/")
    end

    if #arg == 0 then return end
    if arg[1] == "init" then
        local project = arg[2]
        if not project then error("you need a project name") end
        init(project)
    elseif arg[1] == "update" then
        update()
    end
end

zero()
