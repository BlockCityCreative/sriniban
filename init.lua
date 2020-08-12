local storage = minetest.get_mod_storage()
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

minetest.register_chatcommand("add_name", {
    description = "yayyer",
    func = function(name,param)
        if param then
            --banned_names.insert(param)
            minetest.chat_send_all("added to the list of banned words")
            local serial_table = minetest.serialize(banned_names)
            storage:set_string("banned_names", serial_table)    
        end
    
    end
})

minetest.register_chatcommand("show", {
    description = "shower",
    func= function(name,param)
       
       
    end
})
