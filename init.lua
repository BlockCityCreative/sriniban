banned_names={"sex","fuck","damn","drug"}
print("hello world")
minetest.register_on_prejoinplayer(function(name)
for k,v in pairs(banned_names) do
    if string.find(name,v) then
        return "come back with a better name you dolt"
    end
end
end)
