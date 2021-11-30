local RS = game:GetService('ReplicatedStorage')

local mouse = game.Players.LocalPlayer:GetMouse()

local tool = script.Parent
local event = RS:WaitForChild('TaserShotEvent')

local cooldown = false
	
mouse.Button1Down:Connect(function()
	if cooldown == false and script.Parent.BeingAimed.Value == true then
		cooldown = true
			local target = mouse.Hit.p
			event:FireServer(target,tool)
			wait(3)
			cooldown = false
		end
end)
