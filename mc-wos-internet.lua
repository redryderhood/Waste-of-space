local Screen = GetPartFromPort(1, "Screen")
local Keyboard = GetPartFromPort(1, "Keyboard")
local Modem = GetPartFromPort(1, "Modem")
local Centered = 0
local Color = Color3.new(1,1,1)

local StartUP = Screen:CreateElement("TextLabel", {Text = [[web browser
type in a domain (ex:"StarFacts") ]]; TextSize = 20; Size = UDim2.new(1,0,1,0); Font = 12});

local function GetPage(domain)
	Screen:ClearElements()
	local Content = Modem:GetRequest(domain)
	Color = Color3.new(1,1,1)
	Centered = 0
	
	if Content then
		
		if string.match(Content,[[<center>]]) then
			Centered = 2
			Content = string.gsub(Content, [[<center>]], "")
		end
		if string.match(Content,[[<bg>]]) then
			local ColorValue = Content:split([[<bg>]])
			ColorValues = ColorValue[2]:split([[,]])
			Color = Color3.new(tonumber(ColorValues[1]),tonumber(ColorValues[2]),tonumber(ColorValues[3]))
			Content = ColorValue[3]
		end
		if string.match(Content,[[<img]]) then
			local Attributes = {}
			for img in string.gmatch(Content,"<img[^>]+>") do
				for i,str in string.gmatch(img, " ([^=]+)=\"([^\"]+)\"") do
					Attributes[i] = str
				end
				Screen:CreateElement("ImageLabel",{Image = "rbxassetid://"..Attributes["src"]; Size = UDim2.new(0,tonumber(Attributes["width"]) or 100,0,tonumber(Attributes["height"]) or 100); Position = UDim2.new(0,tonumber(Attributes["left"]) or 0,0,tonumber(Attributes["top"]) or 0); BorderSizePixel = 0; BackgroundTransparency = 1})
				Content = string.gsub(Content, "<img[^>]+>", "")
			end
		end
	else
		
		Content = "404 page not found"
	end
	local Body = Screen:CreateElement("Frame", {Size = UDim2.new(1,0,1,0);ZIndex = -1;BackgroundColor3 = Color});
	local BodyContent = Screen:CreateElement("TextLabel", {Text = Content; TextSize = 15; Size = UDim2.new(1,0,1,0); RichText = true; TextXAlignment = Centered; TextYAlignment = 0;BackgroundTransparency = 1; ZIndex = 0; Font = 10;});
end

Keyboard:Connect("TextInputted", GetPage)