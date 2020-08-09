banned_names={"sex","fuck","damn","drug","suicid"}

print("[sriniban] loaded")
minetest.register_on_prejoinplayer(function(name)
    for k,v in pairs(banned_names) do
        if string.find(string.lower(name),string.lower(v)) then
            --logging
            print("[sriniban] user: " .. name .. " attempted to join with disallowed word: " .. v)
            return "your name contains: " .. v .. " and is not allowed here, please come back with a better name"
        end
    end
end)
