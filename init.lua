print("hello world")
minetest.register_on_prejoinplayer(function(name)
if string.find(name,"sex") then
    return "choose a different name"
end
end
)