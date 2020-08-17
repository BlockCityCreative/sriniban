--[[
Copyright 2020 Samarth Ramesh & wsor4035

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

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
            minetest.chat_send_player(name, "Captain Spock tells us that expexting to add a new banned word without specefying it is senseless")
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
    description = "removes a  name from the ban list",
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
