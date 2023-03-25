local Microphone = GetPartFromPort(1, "Microphone")
local Teleporter = GetPartFromPort(1, "Teleporter")
local Speaker = GetPartFromPort(1, "Speaker")

local tele_ops = {
    ["UNAME HERE - IT'S CASE SENSITIVE!"] = true;
}


Microphone:Connect("Chatted", function(Player,Message)
    if Message:lower():sub(0,7) == "tpconf " then
        if tele_ops[Player] then
            local config = Message:sub(8)
            Teleporter:Configure({ Coordinates = config})
            Speaker:Chat("Coords adjusted to ".. config)
        else
            Speaker:Chat("Not a tele op")  
        end
    end
    
    if Message:lower():sub(0,7) == "tp warp" then
        if tele_ops[Player] then
            Speaker:Chat("Have a nice trip!")
            Teleporter:Trigger()
        else
            Speaker:Chat("Not a tele op")
        end
    end
end)