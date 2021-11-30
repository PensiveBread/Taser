local RS = game:GetService('ReplicatedStorage')
local event = RS:FindFirstChild('TaserShotEvent') or Instance.new('RemoteEvent', RS)
event.Name = 'TaserShotEvent'

event.OnServerEvent:Connect(function(player, target, tool) 
    print("fired")
    local fp = tool.FirePart
    local mousepos = target
    local plrdistance = (fp.Position - mousepos).Magnitude

    local Part = Instance.new("Part")
    Part.Parent = workspace
    Part.Material = Enum.Material.Plastic
    Part.Anchored = true
    Part.Size = Vector3.new(0.1,0.1,plrdistance)
    Part.Transparency = 0.65
    Part.Color = Color3.new(0.784314, 0.784314, 0)
    Part.CanCollide = false

    Part.Position = fp.Position:Lerp(mousepos, 0.5)
    Part.CFrame = CFrame.new(Part.Position,mousepos)
    tool.Tased:Play()
    local function GetTouchingParts(part)
        local connection = part.Touched:Connect(function() end)
        local results = part:GetTouchingParts()
        connection:Disconnect()
        return results
    end
    local touching = GetTouchingParts(Part)
    wait(0.1)
    Part:Destroy()
    for i,par in pairs(touching) do
        if par.Parent:FindFirstChild("Humanoid") or par:FindFirstChild("Humanoid") or par.Parent.Parent:FindFirstChild("Humanoid") or par.Name == "Humanoid" then
            if par.Parent:FindFirstChild("Humanoid") then
                humanoid = par.Parent.Humanoid
                break
            elseif par:FindFirstChild("Humanoid") then
                humanoid = par.Humanoid
                break
            elseif par.Parent.Parent:FindFirstChild("Humanoid") then
                humanoid = par.Parent.Parent.Humanoid
                break
            elseif par.Name == "Humanoid" then
                humanoid = par
                break
            end
        end
    end
    
    if humanoid.Parent.Name ~= player.Name then
        humanoid.Parent.HumanoidRootPart.Anchored = true
        humanoid.Health = humanoid.Health - 10
        local loaded = humanoid:LoadAnimation(script.Animation)
        loaded:Play()
        wait(1.5)
        humanoid.Parent.HumanoidRootPart.Anchored = false
    end    
end)
