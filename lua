--reload gui
function Reloadgui()
    for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "T1m Hub" then
            v:Destroy()
        end
    end
--tween 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
    local function customTween(input, studspersecond, offset)
        local char = game:GetService("Players").LocalPlayer.Character;
        local input = input or error("input is nil");
        local studspersecond = studspersecond;
        local offset = offset or CFrame.new(0,0,0);
        local vec3, cframe;
     
        if typeof(input) == "table" then
            vec3 = Vector3.new(unpack(input)); cframe = CFrame.new(unpack(input));
        elseif typeof(input) ~= "Instance" then
            return error("wrong format used");
        end;
        
        Time = (char.HumanoidRootPart.Position - (vec3 or input.Position)).magnitude/200;
        local twn = game.TweenService:Create(char.HumanoidRootPart, TweenInfo.new(Time,Enum.EasingStyle.Linear), {CFrame = (cframe or input.CFrame) * offset});
        twn:Play();
        twn.Completed:Wait();
     end;

     local function customTween2(input, studspersecond, offset)
        local char = game:GetService("Players").LocalPlayer.Character;
        local input = input or error("input is nil");
        local studspersecond = studspersecond;
        local offset = offset or CFrame.new(0,0,0);
        local vec3, cframe;
     
        if typeof(input) == "table" then
            vec3 = Vector3.new(unpack(input)); cframe = CFrame.new(unpack(input));
        elseif typeof(input) ~= "Instance" then
            return error("wrong format used");
        end;
        
        Time = (char.HumanoidRootPart.Position - (vec3 or input.Position)).magnitude/1500;
        local twn = game.TweenService:Create(char.HumanoidRootPart, TweenInfo.new(Time,Enum.EasingStyle.Linear), {CFrame = (cframe or input.CFrame) * offset});
        twn:Play();
        twn.Completed:Wait();
     end;
     -- anti kick(AFK)
     local VirtualUser = game:service'VirtualUser' 
    game:service'Players'.LocalPlayer.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    --NoClip
spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        if getgenv().AutoFarmBoss or getgenv().AutoFarmGahara or getgenv().AutoFarmMugen or getgenv().idletween then
            for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false    
                end
                if v:IsA("Humanoid") then
                    v:ChangeState(11) 
                end
            end
        end
    end)
end)
--kill aura
spawn(function()
    getgenv().Howlongsincelastfired = tick()
    remoteName = "Handle_Initiate_S"
    remoteType = "FireServer"
    
    local meta = getrawmetatable(game)
    setreadonly(meta, false)
    local old_meta = meta.__namecall
    
    meta.__namecall = function(self, ...)
       local method = getnamecallmethod()
    
       if method == remoteType then
           if tostring(self, unpack({...})) == remoteName then
               getgenv().Howlongsincelastfired = tick()
           end
       end
       return old_meta(self, ...)
    end
end)
-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("T1m Hub", 5013109572,os.date())

local page = venyx:addPage("Main", 13503612303)
local Main = page:addSection("Main")

Main:addButton("Reload GUI", function()
    Reloadgui()
end)

Main:addButton("Redeem Code", function()
    game:GetService("ReplicatedStorage").Remotes.send_code_to_server:FireServer("ThanksFor350MVisits")
    wait(12)
    game:GetService("ReplicatedStorage").Remotes.send_code_to_server:FireServer("ThanksFor350MVisits2")
end)
--Auto Farm Main
spawn(function()
    function checkForBosses()
        local Bosses = workspace.Mobs.Bosses:GetChildren() 
        local closestBoss = nil
        local closestDistance = math.huge
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local closestModel
    
        for i, v in pairs(Bosses) do
            if v:FindFirstChildWhichIsA("Model") then
                local Boss = v:FindFirstChildWhichIsA("Model")
                closestModel = Boss
    
                if Boss:FindFirstChild("HumanoidRootPart") then
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude

                    if distance < closestDistance then
                        closestDistance = distance
                        closestBoss = Boss
                    end
                end
            end
        end
    
        if closestBoss == nil and closestModel then
            customTween({closestModel.WorldPivot.Position})
            task.wait()
        else
            return closestBoss
        end
    end
while task.wait() do
    if getgenv().AutoFarmBoss then
        pcall(function()
            if not getgenv().AutoFarmBoss then return end
            local Boss = checkForBosses()
            while Boss and Boss:FindFirstChild("Humanoid") and Boss:FindFirstChild("Humanoid").Health > 0 do
                task.wait()
                local behind = Boss:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, getgenv().mobdis2, 0) + Boss:FindFirstChild("HumanoidRootPart").CFrame.LookVector * getgenv().mobdis
                local bossPosition = Boss.HumanoidRootPart.Position
                local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local distance = (bossPosition - playerPosition).magnitude
                if distance > 350 then
                    customTween({bossPosition})
                    task.wait(3)
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = behind
                    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, Boss.HumanoidRootPart.Position)
                end
            end
            task.wait()
        end)
        task.wait()
    end
end
end)
Main:addToggle("Auto Farm Boss", nil, function(value)
    getgenv().AutoFarmBoss = value
end)
-- Kill Aura Main
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().SwordKillAuraMain and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().FistKillAuraMain and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.5)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().WarFanKillAuraMain and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().ClawKillAuraMain and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().ScytheKillAuraMain and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
getgenv().KillAuraTypeMain = "Combat"
    Main:addDropdown("Kill Aura Method", {"Combat", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraTypeMain = text 

        if getgenv().FistKillAuraMain or getgenv().SwordKillAuraMain or getgenv().WarFanKillAuraMain or getgenv().ClawKillAuraMain or getgenv().ScytheKillAuraMain then
            getgenv().SwordKillAuraMain = false
            getgenv().FistKillAuraMain = false
            getgenv().WarFanKillAuraMain = false
            getgenv().ClawKillAuraMain = false
            getgenv().ScytheKillAuraMain = false
            task.wait(3)
            if getgenv().KillAuraTypeMain == "Combat" then
                getgenv().FistKillAuraMain = true
                getgenv().SwordKillAuraMain = false
                getgenv().WarFanKillAuraMain = false
                getgenv().ClawKillAuraMain = false
                getgenv().ScytheKillAuraMain = false
            elseif getgenv().KillAuraTypeMain == "Sword" then
                getgenv().SwordKillAuraMain = true
                getgenv().FistKillAuraMain = false
                getgenv().WarFanKillAuraMain = false
                getgenv().ClawKillAuraMain = false
                getgenv().ScytheKillAuraMain = false
            elseif getgenv().KillAuraTypeMain == "WarFan" then
                getgenv().SwordKillAuraMain = false
                getgenv().FistKillAuraMain = false
                getgenv().WarFanKillAuraMain = true
                getgenv().ClawKillAuraMain = false
                getgenv().ScytheKillAuraMain = false
            elseif getgenv().KillAuraTypeMain == "Claw" then
                getgenv().SwordKillAuraMain = false
                getgenv().FistKillAuraMain = false
                getgenv().WarFanKillAuraMain = false
                getgenv().ClawKillAuraMain = true
                getgenv().ScytheKillAuraMain = false
            elseif getgenv().KillAuraTypeMain == "Scythe" then
                getgenv().SwordKillAuraMain = false
                getgenv().FistKillAuraMain = false
                getgenv().WarFanKillAuraMain = false
                getgenv().ClawKillAuraMain = false
                getgenv().ScytheKillAuraMain = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraTypeMain == "Combat" then
                    getgenv().FistKillAuraMain = true
                    getgenv().SwordKillAuraMain = false
                    getgenv().WarFanKillAuraMain = false
                    getgenv().ClawKillAuraMain = false
                    getgenv().ScytheKillAuraMain = false
                elseif getgenv().KillAuraTypeMain == "Sword" then
                    getgenv().SwordKillAuraMain = true
                    getgenv().FistKillAuraMain = false
                    getgenv().WarFanKillAuraMain = false
                    getgenv().ClawKillAuraMain = false
                    getgenv().ScytheKillAuraMain = false
                elseif getgenv().KillAuraTypeMain == "WarFan" then
                    getgenv().SwordKillAuraMain = false
                    getgenv().FistKillAuraMain = false
                    getgenv().WarFanKillAuraMain = true
                    getgenv().ClawKillAuraMain = false
                    getgenv().ScytheKillAuraMain = false
                elseif getgenv().KillAuraTypeMain == "Claw" then
                    getgenv().SwordKillAuraMain = false
                    getgenv().FistKillAuraMain = false
                    getgenv().WarFanKillAuraMain = false
                    getgenv().ClawKillAuraMain = true
                    getgenv().ScytheKillAuraMain = false
                elseif getgenv().KillAuraTypeMain == "Scythe" then
                    getgenv().SwordKillAuraMain = false
                    getgenv().FistKillAuraMain = false
                    getgenv().WarFanKillAuraMain = false
                    getgenv().ClawKillAuraMain = false
                    getgenv().ScytheKillAuraMain = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().SwordKillAuraMain = false
                getgenv().FistKillAuraMain = false
                getgenv().WarFanKillAuraMain = false
                getgenv().ClawKillAuraMain = false
                getgenv().ScytheKillAuraMain = false
            end)
        end
    end)
-- Auto BLock
Main:addToggle("Auto Block", nil, function(value)
    if value then
        pcall(function()
            getgenv().AutoBlock = true
            local args = {
                [1] = "add_blocking",
                [2] = "Players."..game.Players.LocalPlayer.Name..".PlayerScripts.Skills_Modules.Combat.Sword//Block",
                [3] = 1,
                [4] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name),
                [5] = 1
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
        end)
    elseif not value then
        pcall(function()
            getgenv().AutoBlock = false
            local args = {
                [1] = "remove_blocking",
                [2] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
        end)
    end
end) 

-- Ouwigahara
local Main = page:addSection("Ouwigahara")
--Auto Farm Ouwigahara
spawn(function()
    function checkForMob()
        local Bosses = workspace.Mobs:GetChildren()
        local closestBoss = nil
        local closestDistance = math.huge
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local closestModel
    
        for i, v in pairs(Bosses) do
            if v:FindFirstChildWhichIsA("Model") then
                local Boss = v:FindFirstChildWhichIsA("Model")
                closestModel = Boss
                if Boss:FindFirstChild("HumanoidRootPart") then
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestBoss = Boss
                    end
                end
            end
        end
    
        if closestBoss == nil and closestModel then
            customTween2({closestModel.WorldPivot.Position})
            task.wait()
        else
            return closestBoss
        end
    end
    while task.wait() do
        if getgenv().AutoFarmGahara then
            pcall(function()
                if not getgenv().AutoFarmGahara then return end
                local Boss = checkForMob()
                while Boss and Boss:FindFirstChild("Humanoid") and Boss:FindFirstChild("Humanoid").Health > 0 do
                    task.wait()
                    local behind = Boss:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, getgenv().mobdis2, 0) + Boss:FindFirstChild("HumanoidRootPart").CFrame.LookVector * getgenv().mobdis
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance > 100 then
                        customTween2({bossPosition})
                        task.wait()
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = behind
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, Boss.HumanoidRootPart.Position)
                    end
                end
                task.wait()
            end)
            task.wait()
        end
    end
end)
Main:addToggle("Auto Farm", nil, function(value)
    local args = {[1] = "Normal"}
game:GetService("ReplicatedStorage"):WaitForChild("TeleportCirclesEvent"):FireServer(unpack(args))
    getgenv().AutoFarmGahara = value
end)
--kill aura Ouwigahara
spawn(function()
    local cdforsword = 1.8
    while task.wait() do
        if getgenv().SwordKillAuraGHR and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.8
    while task.wait() do
        if getgenv().FistKillAuraGHR and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.5)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.97
    while task.wait() do
        if getgenv().WarFanKillAuraGHR and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.97
    while task.wait() do
        if getgenv().ClawKillAuraGHR and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.97
    while task.wait() do
        if getgenv().ScytheKillAuraGHR and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
getgenv().KillAuraTypeGHR = "Combat"
    Main:addDropdown("Kill Aura Method", {"Combat", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraTypeGHR = text 

        if getgenv().FistKillAuraGHR or getgenv().SwordKillAuraGHR or getgenv().WarFanKillAuraGHR or getgenv().ClawKillAuraGHR or getgenv().ScytheKillAuraGHR then
            getgenv().SwordKillAuraGHR = false
            getgenv().FistKillAuraGHR = false
            getgenv().WarFanKillAuraGHR = false
            getgenv().ClawKillAuraGHR = false
            getgenv().ScytheKillAuraGHR = false
            task.wait(3)
            if getgenv().KillAuraTypeGHR == "Combat" then
                getgenv().FistKillAuraGHR = true
                getgenv().SwordKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = false
                getgenv().ClawKillAuraGHR = false
                getgenv().ScytheKillAuraGHR = false
            elseif getgenv().KillAuraTypeGHR == "Sword" then
                getgenv().SwordKillAuraGHR = true
                getgenv().FistKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = false
                getgenv().ClawKillAuraGHR = false
                getgenv().ScytheKillAuraGHR = false
            elseif getgenv().KillAuraTypeGHR == "WarFan" then
                getgenv().SwordKillAuraGHR = false
                getgenv().FistKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = true
                getgenv().ClawKillAuraGHR = false
                getgenv().ScytheKillAuraGHR = false
            elseif getgenv().KillAuraTypeGHR == "Claw" then
                getgenv().SwordKillAuraGHR = false
                getgenv().FistKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = false
                getgenv().ClawKillAuraGHR = true
                getgenv().ScytheKillAuraGHR = false
            elseif getgenv().KillAuraTypeGHR == "Scythe" then
                getgenv().SwordKillAuraGHR = false
                getgenv().FistKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = false
                getgenv().ClawKillAuraGHR = false
                getgenv().ScytheKillAuraGHR = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraTypeGHR == "Combat" then
                    getgenv().FistKillAuraGHR = true
                    getgenv().SwordKillAuraGHR = false
                    getgenv().WarFanKillAuraGHR = false
                    getgenv().ClawKillAuraGHR = false
                    getgenv().ScytheKillAuraGHR = false
                elseif getgenv().KillAuraTypeGHR == "Sword" then
                    getgenv().SwordKillAuraGHR = true
                    getgenv().FistKillAuraGHR = false
                    getgenv().WarFanKillAuraGHR = false
                    getgenv().ClawKillAuraGHR = false
                    getgenv().ScytheKillAuraGHR = false
                elseif getgenv().KillAuraTypeGHR == "WarFan" then
                    getgenv().SwordKillAuraGHR = false
                    getgenv().FistKillAuraGHR = false
                    getgenv().WarFanKillAuraGHR = true
                    getgenv().ClawKillAuraGHR = false
                    getgenv().ScytheKillAuraGHR = false
                elseif getgenv().KillAuraTypeGHR == "Claw" then
                    getgenv().SwordKillAuraGHR = false
                    getgenv().FistKillAuraGHR = false
                    getgenv().WarFanKillAuraGHR = false
                    getgenv().ClawKillAuraGHR = true
                    getgenv().ScytheKillAuraGHR = false
                elseif getgenv().KillAuraTypeGHR == "Scythe" then
                    getgenv().SwordKillAuraGHR = false
                    getgenv().FistKillAuraGHR = false
                    getgenv().WarFanKillAuraGHR = false
                    getgenv().ClawKillAuraGHR = false
                    getgenv().ScytheKillAuraGHR = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().SwordKillAuraGHR = false
                getgenv().FistKillAuraGHR = false
                getgenv().WarFanKillAuraGHR = false
                getgenv().ClawKillAuraGHR = false
                getgenv().ScytheKillAuraGHR = false
            end)
        end
    end)
-- Auto BLock
Main:addToggle("Auto Block", nil, function(value)
    if value then
        pcall(function()
            getgenv().AutoBlock = true
            local args = {
                [1] = "add_blocking",
                [2] = "Players."..game.Players.LocalPlayer.Name..".PlayerScripts.Skills_Modules.Combat.Sword//Block",
                [3] = 1,
                [4] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name),
                [5] = 1
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
        end)
    elseif not value then
        pcall(function()
            getgenv().AutoBlock = false
            local args = {
                [1] = "remove_blocking",
                [2] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
        end)
    end
end) 
    getgenv().mobdis = 0
    Main:addSlider("Distance Between Mobs X [Default: 0]", 0, -20, 20, function(value)
        getgenv().mobdis = value
    end)
    getgenv().mobdis2 = 7.5
    Main:addSlider("Distance Between Mobs Y [Default: 7.5]", 7.5, -20, 20, function(value)
        getgenv().mobdis2 = value
    end)
    Main:addButton("Teleport To Shop Ouwigahara", function()
        game:GetService("ReplicatedStorage"):WaitForChild("TeleportToShop"):FireServer()
    end)
--MUGEN TRAIN
local Main = page:addSection("Mugen Train")
--Auto Farm Mugen Train
spawn(function()
    function checkForMob2()
        local Bosses = workspace.Mobs:GetChildren()
        local closestBoss = nil
        local closestDistance = math.huge
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local closestModel
    
        for i, v in pairs(Bosses) do
            if v:FindFirstChildWhichIsA("Model") then
                local Boss = v:FindFirstChildWhichIsA("Model")
                closestModel = Boss
                if Boss:FindFirstChild("HumanoidRootPart") then
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestBoss = Boss
                    end
                end
            end
        end
    
        if closestBoss == nil and closestModel then
            customTween2({closestModel.WorldPivot.Position})
            task.wait()
        else
            return closestBoss
        end
    end
    while task.wait() do
        if getgenv().AutoFarmMugen then
            pcall(function()
                if not getgenv().AutoFarmMugen then return end
                local Boss = checkForMob2()
                while Boss and Boss:FindFirstChild("Humanoid") and Boss:FindFirstChild("Humanoid").Health > 0 do
                    task.wait()
                    local behind = Boss:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, getgenv().mobdis4, 0) + Boss:FindFirstChild("HumanoidRootPart").CFrame.LookVector * getgenv().mobdis3
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance > 450 then
                        customTween2({bossPosition})
                        task.wait(4)
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = behind
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, Boss.HumanoidRootPart.Position)
                    end
                end
                task.wait()
            end)
            task.wait()
        end
    end
end)
Main:addToggle("Auto Farm", nil, function(value)
    getgenv().AutoFarmMugen = value
end)

-- Kill Aura Mugen Train
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().SwordKillAuraMGT and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Sword_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().FistKillAuraMGT and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fist_combat"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.5)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().WarFanKillAuraMGT and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "fans_combat_slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().ClawKillAuraMGT and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "claw_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 1.75
    while task.wait() do
        if getgenv().ScytheKillAuraMGT and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                if getgenv().AutoBlock and game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun") then
                    repeat task.wait() until not game:GetService("ReplicatedStorage").PlayerValues:FindFirstChild(LocalPlayer.Name):FindFirstChild("Stun")
                elseif (tick() - getgenv().Howlongsincelastfired) > cdforsword then 
                    for i = 1, 7 do
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = math.huge
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                        
                        local ohString1 = "Scythe_Combat_Slash"
                        local ohInstance2 = game:GetService("Players").LocalPlayer
                        local ohInstance3 = ohInstance2.Character
                        local ohInstance4 = ohInstance2.Character.HumanoidRootPart
                        local ohInstance5 = ohInstance2.Character.Humanoid
                        local ohNumber6 = 919
                        local ohString7 = "ground_slash"
                        
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohNumber6, ohString7)
                    end
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
getgenv().KillAuraTypeMGT = "Combat"
    Main:addDropdown("Kill Aura Method", {"Combat", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraTypeMGT = text 

        if getgenv().FistKillAuraMGT or getgenv().SwordKillAuraMGT or getgenv().WarFanKillAuraMGT or getgenv().ClawKillAuraMGT or getgenv().ScytheKillAuraMGT then
            getgenv().SwordKillAuraMGT = false
            getgenv().FistKillAuraMGT = false
            getgenv().WarFanKillAuraMGT = false
            getgenv().ClawKillAuraMGT = false
            getgenv().ScytheKillAuraMGT = false
            task.wait(3)
            if getgenv().KillAuraTypeMGT == "Combat" then
                getgenv().FistKillAuraMGT = true
                getgenv().SwordKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = false
                getgenv().ClawKillAuraMGT = false
                getgenv().ScytheKillAuraMGT = false
            elseif getgenv().KillAuraTypeMGT == "Sword" then
                getgenv().SwordKillAuraMGT = true
                getgenv().FistKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = false
                getgenv().ClawKillAuraMGT = false
                getgenv().ScytheKillAuraMGT = false
            elseif getgenv().KillAuraTypeMGT == "WarFan" then
                getgenv().SwordKillAuraMGT = false
                getgenv().FistKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = true
                getgenv().ClawKillAuraMGT = false
                getgenv().ScytheKillAuraMGT = false
            elseif getgenv().KillAuraTypeMGT == "Claw" then
                getgenv().SwordKillAuraMGT = false
                getgenv().FistKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = false
                getgenv().ClawKillAuraMGT = true
                getgenv().ScytheKillAuraMGT = false
            elseif getgenv().KillAuraTypeMGT == "Scythe" then
                getgenv().SwordKillAuraMGT = false
                getgenv().FistKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = false
                getgenv().ClawKillAuraMGT = false
                getgenv().ScytheKillAuraMGT = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraTypeMGT == "Combat" then
                    getgenv().FistKillAuraMGT = true
                    getgenv().SwordKillAuraMGT = false
                    getgenv().WarFanKillAuraMGT = false
                    getgenv().ClawKillAuraMGT = false
                    getgenv().ScytheKillAuraMGT = false
                elseif getgenv().KillAuraTypeMGT == "Sword" then
                    getgenv().SwordKillAuraMGT = true
                    getgenv().FistKillAuraMGT = false
                    getgenv().WarFanKillAuraMGT = false
                    getgenv().ClawKillAuraMGT = false
                    getgenv().ScytheKillAuraMGT = false
                elseif getgenv().KillAuraTypeMGT == "WarFan" then
                    getgenv().SwordKillAuraMGT = false
                    getgenv().FistKillAuraMGT = false
                    getgenv().WarFanKillAuraMGT = true
                    getgenv().ClawKillAuraMGT = false
                    getgenv().ScytheKillAuraMGT = false
                elseif getgenv().KillAuraTypeMGT == "Claw" then
                    getgenv().SwordKillAuraMGT = false
                    getgenv().FistKillAuraMGT = false
                    getgenv().WarFanKillAuraMGT = false
                    getgenv().ClawKillAuraMGT = true
                    getgenv().ScytheKillAuraMGT = false
                elseif getgenv().KillAuraTypeMGT == "Scythe" then
                    getgenv().SwordKillAuraMGT = false
                    getgenv().FistKillAuraMGT = false
                    getgenv().WarFanKillAuraMGT = false
                    getgenv().ClawKillAuraMGT = false
                    getgenv().ScytheKillAuraMGT = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().SwordKillAuraMGT = false
                getgenv().FistKillAuraMGT = false
                getgenv().WarFanKillAuraMGT = false
                getgenv().ClawKillAuraMGT = false
                getgenv().ScytheKillAuraMGT = false
            end)
        end
    end)

    Main:addToggle("Auto Block", nil, function(value)
        if value then
            pcall(function()
                getgenv().AutoBlock = true
                local args = {
                    [1] = "add_blocking",
                    [2] = "Players."..game.Players.LocalPlayer.Name..".PlayerScripts.Skills_Modules.Combat.Sword//Block",
                    [3] = 1,
                    [4] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name),
                    [5] = 1
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
            end)
        elseif not value then
            pcall(function()
                getgenv().AutoBlock = false
                local args = {
                    [1] = "remove_blocking",
                    [2] = game:GetService("ReplicatedStorage"):WaitForChild("PlayerValues"):WaitForChild(game.Players.LocalPlayer.Name)
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
            end)
        end
    end) 

    getgenv().mobdis3 = 11
    Main:addSlider("Distance Between Mobs X [Default: 11]", 11, -16, 16, function(value)
        getgenv().mobdis3 = value
    end)
    getgenv().mobdis4 = 0
    Main:addSlider("Distance Between Mobs Y [Default: 0]", 0, -16, 16, function(value)
        getgenv().mobdis4 = value
    end)
    Main:addButton("Buy Mugen Train Ticket", function()
        local args = {[1] = 1}
        game:GetService("ReplicatedStorage"):WaitForChild("purchase_mugen_ticket"):FireServer(unpack(args))        
    end)
--Section 2 | MISC 
    local page2 = venyx:addPage("Misc", 13677751482)
    local Misc = page2:addSection("Local Player - Human")
    
    Misc:addToggle("Mode Rengoku [Human]", false, function(value)
        if value then
            pcall(function()
                getgenv().Rengoku = true
            game:GetService("ReplicatedStorage").Remotes.heart_ablaze_mode_remote:FireServer(true)
            end)
        elseif not value then
            pcall(function()
                getgenv().Rengoku = false
            game:GetService("ReplicatedStorage").Remotes.heart_ablaze_mode_remote:FireServer(false)
            end)
        end
    end)

    Misc:addToggle("Mode Zennitsu [Human]", false, function(value)
        if value then
            pcall(function()
                getgenv().Zennitsu = true
                game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(true)
            end)
        elseif not value then
            pcall(function()
                getgenv().Zennitsu = false
                game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(false)
            end)
        end
    end)
    Misc:addToggle("Regen HP [Human/Demon]", false, function(value)
        if value then
            pcall(function()
                getgenv().RegenBreathing = true 
            game:GetService("ReplicatedStorage").Remotes.regeneration_breathing_remote:FireServer(true)
            end)
        elseif not value then
            pcall(function()
                getgenv().RegenBreathing = false
            game:GetService("ReplicatedStorage").Remotes.regeneration_breathing_remote:FireServer(false)
            end)
        end
    end)
    --Inf Breathing/Stam
spawn(function()
    while task.wait() do
        if getgenv().AutoStamina then
            getrenv()._G.AddStamina("gpthebest", 50)
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().AutoBreathing then
            getrenv()._G.AddBreath("gpthebest", 50)
        end
    end
end)
    Misc:addToggle("Infinity Breathing", false, function(value)
        getgenv().AutoBreathing = value
    end)
    Misc:addToggle("Infinity Stamina", false, function(value)
        getgenv().AutoStamina = value
    end)
    local Misc = page2:addSection("Local Player")
    Misc:addToggle("Auto War Drums", false, function(value)
        if value then
            while value == true do
            local args = {[1] = true}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("war_Drums_remote"):FireServer(unpack(args))
wait(22)
        end 
    end
    end)

    Misc:addToggle("No Sun Damage", false, function(value)
        if value then
            pcall(function()
                getgenv().SunDamage = true
                game:GetService("Players").LocalPlayer.PlayerScripts["Small_Scripts"].Gameplay["Sun_Damage"].Disabled = true
            end)
        elseif not value then
            pcall(function()
                getgenv().SunDamage = false
                game:GetService("Players").LocalPlayer.PlayerScripts["Small_Scripts"].Gameplay["Sun_Damage"].Disabled = false
            end)
        end
    end)

    local Misc = page2:addSection("God Mode")
    Misc:addToggle("God Mode [Only Kamado]", false, function(value)
        if value then
            pcall(function()
                getgenv().Kamado = true
    game:GetService("ReplicatedStorage").Remotes.heal_tang123asd:FireServer(true)
        end)
    elseif not value then
        pcall(function()
            getgenv().Kamado = false
    game:GetService("ReplicatedStorage").Remotes.heal_tang123asd:FireServer(false)
        end)
    end
    end)

    Misc:addToggle("God Mode [Only Douma]", false, function(value)
        if value then
            while value == true do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "ice_demon_art_bodhisatva",
                [4] = 1}
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))            
            wait(2)
        end
    end
    end)
    Misc:addToggle("God Mode [Only Akaza]", false, function(value)
        if value then
            while value == true do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "akaza_bda_compass_needle",
                [4] = 1}
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))            
            wait(2)
        end
    end
    end)
     --Muzan
    local Misc = page2:addSection("Quest Muzan")
--Telport Muzan 525.875, 321.917, -2304.85
    Misc:addButton("Teleport To Muzan", function()
        game.Players.LocalPlayer.Character:MoveTo(game:GetService("Workspace").Muzan.SpawnPos.Value) 
    end)
--Teleport Flower (Reset To Stop)
local player = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local force = Instance.new("BodyVelocity")
force.Velocity = Vector3.new(0, 0, 0)


function tween(P1)
    Distance = (P1.Position - player.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 150 then
        Speed = 20000
    elseif Distance < 200 then
        Speed = 5000
    elseif Distance < 300 then
        Speed = 1030
    elseif Distance < 500 then
        Speed = 725
    elseif Distance < 1000 then
        Speed = 365
    elseif Distance >= 1000 then
        Speed = 365
    end
    local twen = ts:Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    )

    twen:Play()
    force.Parent = player.Character.HumanoidRootPart
    wait(Distance/Speed)
    force.Parent = nil
        
        
        for i, v in pairs(workspace.Demon_Flowers_Spawn:GetDescendants()) do
            if v.Name == "Cube.002" then
                for i, v in pairs(workspace.Demon_Flowers_Spawn:GetDescendants()) do
                    if v.Name == "Cancel" then
                        v:Destroy()
                    end
                end
                ts:Create(player.Character.HumanoidRootPart,
                TweenInfo.new(1, Enum.EasingStyle.Linear),
                {CFrame = CFrame.new(v.Position)}):Play()
                force.Parent = player.Character.HumanoidRootPart
                wait(1.2)
                pcall(function()
                    fireproximityprompt(v.Pick_Demon_Flower_Thing)
                end)
                wait(.3)
                force.Parent = nil
                v.Parent:Destroy()
            end
        end
end


function idletween()
    task.spawn(function()
        if idletween then
        while task.wait() do
            tween(CFrame.new(118, 282, -1630))
            
            tween(CFrame.new(1466, 297, -3025))
            
            tween(CFrame.new(1871, 317, -3120))

            tween(CFrame.new(3083, 317, -3287))
            
            tween(CFrame.new(3245, 317, -2720))

            tween(CFrame.new(3869, 343, -3121))
            
            tween(CFrame.new(5186, 365, -2435))
            
            tween(CFrame.new(123, 275, -3275))
            
            tween(CFrame.new(-328, 426, -2188))

    end
    end
    end)
    end

Misc:addToggle("Tween To Flower", false, function(a)
	getgenv().idletween = a
    idletween()
end)
--Quest Soryu
getgenv().mobdis5 = 0
getgenv().mobdis6 = 7
spawn(function()
    function checkForAkaza()
        local Bosses = workspace.Mobs.Bosses.Akaza:GetChildren()
        local closestBoss = nil
        local closestDistance = math.huge
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local closestModel
    
        for i, v in pairs(Bosses) do
            if v:FindFirstChildWhichIsA("Model") then
                local Boss = v:FindFirstChildWhichIsA("Model")
                closestModel = Boss
                if Boss:FindFirstChild("HumanoidRootPart") then
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestBoss = Boss
                    end
                end
            end
        end
    
        if closestBoss == nil and closestModel then
            customTween2({closestModel.WorldPivot.Position})
            task.wait()
        else
            return closestBoss
        end
    end
    while task.wait() do
        if getgenv().AutoBossAkaza then
            pcall(function()
                if not getgenv().AutoBossAkaza then return end
                local Boss = checkForAkaza()
                while Boss and Boss:FindFirstChild("Humanoid") and Boss:FindFirstChild("Humanoid").Health > 0 do
                    task.wait()
                    local behind = Boss:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, getgenv().mobdis6, 0) + Boss:FindFirstChild("HumanoidRootPart").CFrame.LookVector * getgenv().mobdis5
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance > 200 then
                        customTween2({bossPosition})
                        task.wait()
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = behind
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, Boss.HumanoidRootPart.Position)
                    end
                end
                task.wait()
            end)
            task.wait()
        end
    end
end)
spawn(function()
    function checkForMob20KDMG()
        local Bosses = workspace.Mobs.Village_1_quest_bandits:GetChildren()
        local closestBoss = nil
        local closestDistance = math.huge
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local closestModel
    
        for i, v in pairs(Bosses) do
            if v:FindFirstChildWhichIsA("Model") then
                local Boss = v:FindFirstChildWhichIsA("Model")
                closestModel = Boss
                if Boss:FindFirstChild("HumanoidRootPart") then
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestBoss = Boss
                    end
                end
            end
        end
    
        if closestBoss == nil and closestModel then
            customTween2({closestModel.WorldPivot.Position})
            task.wait()
        else
            return closestBoss
        end
    end
    while task.wait() do
        if getgenv().AutoMob20KDMG then
            pcall(function()
                if not getgenv().AutoMob20KDMG then return end
                local Boss = checkForMob20KDMG()
                while Boss and Boss:FindFirstChild("Humanoid") and Boss:FindFirstChild("Humanoid").Health > 0 do
                    task.wait()
                    local behind = Boss:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, getgenv().mobdis6, 0) + Boss:FindFirstChild("HumanoidRootPart").CFrame.LookVector * getgenv().mobdis5
                    local bossPosition = Boss.HumanoidRootPart.Position
                    local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local distance = (bossPosition - playerPosition).magnitude
                    if distance > 200 then
                        customTween2({bossPosition})
                        task.wait()
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = behind
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, Boss.HumanoidRootPart.Position)
                    end
                end
                task.wait()
            end)
            task.wait()
        end
    end
end)
    local Misc = page2:addSection("Quest Soryu")
    Misc:addButton("Teleport To Soryu Book", false, function()
    end)
    Misc:addToggle("Auto Farm Akaza", false, function(value)
        getgenv().AutoBossAkaza = value
    end)
    Misc:addToggle("Auto Farm 20K Damage", false, function(value)
        getgenv().AutoMob20KDMG = value
    end)
--Other
    local Misc = page2:addSection("Other")
    Misc:addKeybind("Keybind Turn ON/OFF", Enum.KeyCode.LeftControl, function()
        venyx:toggle()
    end, function()
    end)

    Misc:addToggle("Collect Daily Spin", false, function(state)
        _G.DailySpin = state
        while _G.DailySpin do task.wait()
            pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("spins_thing_remote"):InvokeServer()
       end)
        end
    end)
    Misc:addToggle("Collect Loot", true, function(value)
        getgenv().AutoLoot = value        
    end)
    spawn(function()
        getgenv().AutoLoot = true
        getgenv().TotalChest = 0
        getgenv().TotalItem = 0
    
        while task.wait() do
            if getgenv().AutoLoot then
                pcall(function()
                    local chests = workspace:WaitForChild("Debree"):GetChildren()
                    for i, v in pairs(chests) do
                        if v.Name == "Loot_Chest" and v:FindFirstChild("Root") and v:FindFirstChild("Drops") then
                                getgenv().TotalChest = getgenv().TotalChest + 1
                                for i, v1 in pairs(v.Drops:GetChildren()) do
                                    local args = {
                                        [1] = v1.Name
                                    }
                                    v:WaitForChild("Add_To_Inventory"):InvokeServer(unpack(args))
                                    task.wait()
                                    getgenv().TotalItem = getgenv().TotalItem + 1
                                end
                                task.wait(0)
                                v:Destroy()
                            end
                    end
                end)
            end
        end
    end)

    venyx:SelectPage(venyx.pages[1], true)
end
Reloadgui()

--toan bo code deu cho newbie hoc tap, chac chan 100% khong hoan hao nhung se huu dung voi newbie
