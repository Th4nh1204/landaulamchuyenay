
function Reloadgui()
    for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "T1m Hub" then
            v:Destroy()
        end
    end

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
        
        Time = (char.HumanoidRootPart.Position - (vec3 or input.Position)).magnitude/700;
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
-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("T1m Hub", 5013109572,os.date())

local page = venyx:addPage("Main", 13503612303)
local Main = page:addSection("Main")

Main:addButton("Reload GUI", function()
    Reloadgui()
end)

Main:addButton("Redeem Code", function()
    game:GetService("ReplicatedStorage").Remotes.send_code_to_server:FireServer("ThanksForLikes600K")
    wait(10)
    game:GetService("ReplicatedStorage").Remotes.send_code_to_server:FireServer("ThanksForLikes600K2")
end)

Main:addToggle("Auto Farm Boss", nil, function(value)
    getgenv().AutoFarmBoss = value
end)
-- Kill Aura
getgenv().KillAuraType = "Fist"
    Main:addDropdown("Kill Aura Method", {"Fist", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraType = text 

        if getgenv().FistKillAura or getgenv().SwordKillAura or getgenv().WarFanKillAura or getgenv().ClawKillAura or getgenv().ScytheKillAura or getgenv().AutoBlock then
            getgenv().SwordKillAura = false
            getgenv().FistKillAura = false
            getgenv().WarFanKillAura = false
            getgenv().ClawKillAura = false
            getgenv().ScytheKillAura = false
            getgenv().AutoBlock = false
            task.wait(3)
            if getgenv().KillAuraType == "Fist" then
                getgenv().AutoBlock = true
                getgenv().FistKillAura = true
                getgenv().SwordKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Sword" then
                getgenv().SwordKillAura = true
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "WarFan" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = true
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Claw" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = true
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Scythe" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraType == "Fist" then
                    getgenv().AutoBlock = true
                    getgenv().FistKillAura = true
                    getgenv().SwordKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Sword" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = true
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "WarFan" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = true
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Claw" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = true
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Scythe" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().AutoBlock = false
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
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
Main:addToggle("Auto Farm", nil, function(value)
    getgenv().AutoFarmGahara = value
end)
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
            task.wait(0)
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
                    if distance > 200 then
                        customTween2({bossPosition})
                        task.wait(2)
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
            task.wait(0)
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
            task.wait(0)
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

spawn(function()
    local cdforsword = 2
    while task.wait() do
        if getgenv().SwordKillAura and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
    local cdforsword = 2
    while task.wait() do
        if getgenv().FistKillAura and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
                    task.wait(0.1)
                    getgenv().Howlongsincelastfired = tick()    
                end
            end)
        end
    end
end)
spawn(function()
    local cdforsword = 2
    while task.wait() do
        if getgenv().WarFanKillAura and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
    local cdforsword = 2
    while task.wait() do
        if getgenv().ClawKillAura and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
    local cdforsword = 2
    while task.wait() do
        if getgenv().ScytheKillAura and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
-- Kill Aura
getgenv().KillAuraType = "Fist"
    Main:addDropdown("Kill Aura Method", {"Fist", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraType = text 

        if getgenv().FistKillAura or getgenv().SwordKillAura or getgenv().WarFanKillAura or getgenv().ClawKillAura or getgenv().ScytheKillAura or getgenv().AutoBlock then
            getgenv().SwordKillAura = false
            getgenv().FistKillAura = false
            getgenv().WarFanKillAura = false
            getgenv().ClawKillAura = false
            getgenv().ScytheKillAura = false
            getgenv().AutoBlock = false
            task.wait(3)
            if getgenv().KillAuraType == "Fist" then
                getgenv().AutoBlock = true
                getgenv().FistKillAura = true
                getgenv().SwordKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Sword" then
                getgenv().SwordKillAura = true
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "WarFan" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = true
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Claw" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = true
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Scythe" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraType == "Fist" then
                    getgenv().AutoBlock = true
                    getgenv().FistKillAura = true
                    getgenv().SwordKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Sword" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = true
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "WarFan" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = true
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Claw" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = true
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Scythe" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().AutoBlock = false
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
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
    getgenv().mobdis2 = 17
    Main:addSlider("Distance Between Mobs Y [Default: 17]", 17, -20, 20, function(value)
        getgenv().mobdis2 = value
    end)
    Main:addButton("Teleport To Shop Ouwigahara", function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game:GetService("Workspace").Map["Shop Room"].MeshPart.CFrame)
    end)
--MUGEN TRAIN
    local Main = page:addSection("Mugen Train")
Main:addToggle("Auto Farm", nil, function(value)
    getgenv().AutoFarmMugen = value
end)

-- Kill Aura
getgenv().KillAuraType = "Fist"
    Main:addDropdown("Kill Aura Method", {"Fist", "Sword", "WarFan", "Claw", "Scythe"}, function(text)
        getgenv().KillAuraType = text 

        if getgenv().FistKillAura or getgenv().SwordKillAura or getgenv().WarFanKillAura or getgenv().ClawKillAura or getgenv().ScytheKillAura or getgenv().AutoBlock then
            getgenv().SwordKillAura = false
            getgenv().FistKillAura = false
            getgenv().WarFanKillAura = false
            getgenv().ClawKillAura = false
            getgenv().ScytheKillAura = false
            getgenv().AutoBlock = false
            task.wait(3)
            if getgenv().KillAuraType == "Fist" then
                getgenv().AutoBlock = true
                getgenv().FistKillAura = true
                getgenv().SwordKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Sword" then
                getgenv().SwordKillAura = true
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "WarFan" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = true
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Claw" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = true
                getgenv().ScytheKillAura = false
            elseif getgenv().KillAuraType == "Scythe" then
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = true
            end
        end
    end)
    Main:addToggle("Kill Aura", nil, function(value)
        if value then
            pcall(function()
                if getgenv().KillAuraType == "Fist" then
                    getgenv().AutoBlock = true
                    getgenv().FistKillAura = true
                    getgenv().SwordKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Sword" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = true
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "WarFan" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = true
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Claw" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = true
                    getgenv().ScytheKillAura = false
                elseif getgenv().KillAuraType == "Scythe" then
                    getgenv().AutoBlock = true
                    getgenv().SwordKillAura = false
                    getgenv().FistKillAura = false
                    getgenv().WarFanKillAura = false
                    getgenv().ClawKillAura = false
                    getgenv().ScytheKillAura = true
                end
            end)
        elseif not value then
            pcall(function()
                getgenv().AutoBlock = false
                getgenv().SwordKillAura = false
                getgenv().FistKillAura = false
                getgenv().WarFanKillAura = false
                getgenv().ClawKillAura = false
                getgenv().ScytheKillAura = false
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
    local Misc = page2:addSection("Local Player")
    
    Misc:addToggle("Semi Kamado [Only Kamado]", false, function(value)
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
    
    Misc:addToggle("Semi Rengoku [Only Human]", false, function(value)
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

    Misc:addToggle("Regen HP [Only Human]", false, function(value)
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

    Misc:addToggle("Auto Breathing", false, function(value)
        if value then
            pcall(function()
                getgenv().AutoBreathing = true
            game:GetService("ReplicatedStorage").Remotes.war_Drums_remote:FireServer(true)
            end)
        elseif not value then
            pcall(function()
                getgenv().AutoBreathing = false
            game:GetService("ReplicatedStorage").Remotes.war_Drums_remote:FireServer(false)
            end)
        end
    end)
     --Muzan
    local Misc = page2:addSection("Quest Muzan")
--Telport Muzan
    Misc:addButton("Teleport To Muzan", function()
        game.Players.LocalPlayer.Character:MoveTo(game:GetService("Workspace").Muzan.SpawnPos.Value) 
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
    
        while task.wait(0.7) do
            if getgenv().AutoLoot then
                pcall(function()
                    local chests = workspace:WaitForChild("Debree"):GetChildren()
    
                    for i, v in pairs(chests) do
                        if v.Name == "Loot_Chest" and v:FindFirstChild("Root") and v:FindFirstChild("Drops") then
                            if (v.Root.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 30 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Root.CFrame 
                                print("CHEST FOUND")
                                getgenv().TotalChest = getgenv().TotalChest + 1
                                for i, v1 in pairs(v.Drops:GetChildren()) do
                                    local args = {
                                        [1] = v1.Name
                                    }
                                    v:WaitForChild("Add_To_Inventory"):InvokeServer(unpack(args))
                                    task.wait()
                                    getgenv().TotalItem = getgenv().TotalItem + 1
                                end
                                task.wait(0.7)
                                v:Destroy()
                            end
                        end
                    end
                end)
            end
        end
    end)
    Misc:addToggle("Test", false, function(value)
        print("Quack Quack Quack", value)
    end)
    spawn(function()
        while task.wait() do
            if getgenv().Noclip == true then
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                        v.CanCollide = false
                    end
                end
            end
        end
    end)
    Misc:addToggle("Noclip", nil, function(value)
        getgenv().Noclip = value
        wait(0.5)
        if not getgenv().Noclip then
            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                    v.CanCollide = true
                end
            end
        end
    end)
    venyx:SelectPage(venyx.pages[1], true)
end
Reloadgui()
