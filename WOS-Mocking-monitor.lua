local microphone = GetPartFromPort(2,"Microphone")
local Screen = GetPartFromPort(1,"Screen")

microphone:Connect("Chatted", function(Player, Message)
    local show = Message:sub(8)
    Screen:CreateElement('TextLabel', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromScale(1, 1);
        Text = show;
        TextSize = 5;
        TextScaled = false;
    })
end)