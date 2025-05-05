# luabc (Lua Build C)

An easy way to build C projects using Lua.

## Usage of 'zero':
'zero' is a very simple tool for initializing a C project.

If you want to use it, you should make sure to update certain settings in `build.lua` (I’ve added some information there).


It might not work correctly on your machine due to differences in Lua interpreter names or versions. You may need to update some configurations in `build.lua`.

```console
$ lua build.lua
$ ./zero init new_project
$ cd new_project
$ lua build.lua
hello world
```

## Usage of 'luabc':

Copy the `luabc.lua` file into your project, and write the `build.lua` file to call the API for building your project.

### Ubuntu

Usage:
```console
$ cd examples/helloworld
$ lua build.lua
$ ./helloworld
hello world
```

### Windows

```console
$ cd examples/helloworld
$ lua build.lua
$ .\helloworld.exe
hello world
```