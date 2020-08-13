local storage = minetest.get_mod_storage()
minetest.deserialize(storage:get_string("banned_names"))
banned_names=minetest.deserialize(storage:get_string("banned_names")) or {"sex","fuck","damn","drug","suicid"}

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
    params = "<string>",
    privs = {server= true},
    description = "adds a name to banlist\nCAUTION adding a single letter can be catastrophic. always be careful when adding names",
    func = function(name,param)
        if param ~= "" then
            table.insert(banned_names,tostring(param))
            print(tostring(param))
            minetest.chat_send_all("added "..param.." to the list of banned words")
            local serial_table = minetest.serialize(banned_names)
            storage:set_string("banned_names", serial_table)    
        
        else 
            minetest.chat_send_player(name, "Captain Spock tells us that expexted to add a new banned word without an argument is senseless")
        end
    
    end
})

minetest.register_chatcommand("list_names", {
    description = "lists all the banned names",
    privs = {server= true},
    func= function(name)
       for k,v in pairs(banned_names) do
            minetest.chat_send_player(name, banned_names[k])
       end
    end
})

minetest.register_chatcommand("rm-name",{
    description - "removes a  name from the ban list",
    params = "<name>",
    privs = {server=true},
    func = function(name, param)
        if param ~="" then    
            for k in pairs(banned_names) do
                if param == banned_names[k] then
                    table.remove(banned_names,k)
                end   
            end
            storage:set_string("banned_names", minetest.serialize(banned_names))
        end
    end

})
