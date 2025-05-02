#include <stdio.h>
#include "lua.h"
#include "lauxlib.h"

#define ZERO_LUA "/home/dylaris/dotfiles/zero.lua"

int main(int argc, char **argv)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    lua_newtable(L);
    for (int i = 1; i < argc; i++) {
        lua_pushinteger(L, i);
        lua_pushstring(L, argv[i]);
        lua_settable(L, -3);
    }
    lua_setglobal(L, "arg");

    if (luaL_dofile(L, ZERO_LUA) != LUA_OK) {
        fprintf(stderr, "zero error: %s\n", lua_tostring(L, -1));
        return 1;
    }

    lua_close(L);
    return 0;
}
