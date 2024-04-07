local mc = {}

mc.CustomMouseIconEnabled = false
mc.Icon = ""

local plrMouse = game.Players.LocalPlayer:GetMouse()

local rbxGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("RobloxGui")
if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled and not
	game:GetService("UserInputService").MouseEnabled then
	return mc
end
local mouseImage = game.Players.LocalPlayer.PlayerGui:WaitForChild("FakeMouseGui"):WaitForChild("FakeMouse")

function mc:ChangeMouseIcon(icon)
	mc.CustomMouseIconEnabled = true
	mc.Icon = icon
	
	if rbxGui:WaitForChild("MouseLocked").Value then
		task.spawn(function()
			repeat task.wait() until rbxGui.MouseLocked.Value == false
			mouseImage.Image = icon
		end)
	else
		mouseImage.Image = icon
	end
end

function mc:DisableCustomIcon()
	mc.CustomMouseIconEnabled = false
	mc.Icon = ""
	mouseImage.Image = "rbxassetid://7471776177"
end

game:GetService("RunService").RenderStepped:Connect(function()
	if not mc.CustomMouseIconEnabled and mc.Icon ~= "" then
		mc:ChangeMouseIcon(mc.Icon)
	elseif mc.CustomMouseIconEnabled and mc.Icon ~= "" and mouseImage.Image ~= mc.Icon then
		mc:ChangeMouseIcon(mc.Icon)
	elseif mc.CustomMouseIconEnabled and mc.Icon == "" then
		mc:DisableCustomIcon()
	end
end)

plrMouse:GetPropertyChangedSignal("Icon"):Connect(function()
	if plrMouse.Icon ~= "" then
		mc:ChangeMouseIcon(plrMouse.Icon)
	else
		mc:DisableCustomIcon()
	end
end)

return mc
