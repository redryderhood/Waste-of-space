local grav = GetPartFromPort(1,"GravityGenerator")
local microphone = GetPartFromPort(1,"Microphone")
local speaker = GetPartFromPort(1, "Speaker")
local switch = GetPartFromPort(1,"Switch")


local ops = {
    ["UNAME HERE - IT'S CASE SENSITIVE!"] = true;
}


microphone:Connect("Chatted", function(player, message) 
    if message:lower():sub(0,8) == "setgrav " then
        if not ops[player] then
            speaker:Chat("Not a space station commander.")
            return
        end
        local config = message:sub(9)
        grav:Configure({Gravity = config})
        speaker:Chat("Successfully changed gravity to " .. config)
    end
    if message:lower():sub(0,2) == "d " then
        if not ops[player] then
            speaker:Chat("Not a space station commander.")
            return
        end
        if message:sub(3) == "e on" then
            speaker:Chat("Enabling energy shield")
            switch:Configure({SwitchValue = true})
        end
        if message:sub(3) == "e off" then
            speaker:Chat("Disabling energy shield")
            switch:Configure({SwitchValue = false})
        end
    end
end)


