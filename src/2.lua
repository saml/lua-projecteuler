-- using LGMP (Lua GMP binding)
-- http://members.chello.nl/~w.couwenberg/lgmp.htm
--
-- compiled lgmp with:
-- gcc -O2 -Wall -I$HOME/opt/gmp/include -I$HOME/opt/lua/include lgmp.c   -L$HOME/opt/gmp/lib -L$HOME/opt/lua/lib -lm -llua -lgmp -shared -o gmp.so
--
--lua is invoked as:
--[[
LUA_HOME="$HOME/opt/lua"
export LUA_PATH="$LUA_PATH;./?.lua;$LUA_HOME/luamodules/?.lua"
export LUA_CPATH="$LUA_CPATH;./?.so;$LUA_HOME/luamodules/?.so"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/opt/gmp/lib:$LUA_HOME/lib"
"$LUA_HOME/bin/lua" -lreadline -lcomplete $*
--]]

local fibs = (function()
    local a = 1
    local b = 2
    local nextFib = function()
        while true do
            local sum = a + b
            local result = a
            a,b = b,sum
            coroutine.yield(result)
        end
    end
    return nextFib
end)()

local co = coroutine.create(fibs)

local fib = function()
    return coroutine.resume(co)
end

local main = function()
    local sum = 0
    while true do
        local _,x = fib()
        if x > 4000000 then
            break
        end
        if x % 2 == 0 then
            sum = sum + x
        end
    end
    print(sum)
end

main()
