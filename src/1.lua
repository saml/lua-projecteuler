local main = function()
    local sum = 0
    for x=1,1000-1,1 do
        if x % 3 == 0 or x % 5 == 0 then
            sum = sum + x
        end
    end
    print(sum)
end

main()

