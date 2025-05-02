function getParameterNames(func)
    local paramNames = {}
    -- 模拟调用 func 并查看其参数
    local i = 1
    while true do
        local name = debug.getlocal(2, i)  -- 获取当前栈帧的局部变量名
        if not name then
            break
        end
        table.insert(paramNames, name)  -- 只保存参数名称
        i = i + 1
    end
    return paramNames
end

-- 示例函数
function exampleFunction(...)
    local paramNames = getParameterNames(exampleFunction)
    print("参数名称：")
    for _, name in ipairs(paramNames) do
        print(name)
    end
end

exampleFunction(1, 2, 3, 5, 6)
