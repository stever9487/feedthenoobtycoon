local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()
local win = library:Window("Feed The Noob Tycoon")
local serv = win:Server("Cheats", "")
local autofarms = serv:Channel("auto-farms")
local frenzy = serv:Channel("frenzy-time")
local misc = serv:Channel("misc")
local tycoon
for i, v in pairs(game:GetService("Workspace").Tycoons:GetChildren()) do
    if v:FindFirstChild("TycoonInfo").Owner.Value == game:GetService("Players").LocalPlayer then
        tycoon = v
        misc:Label("you have tycoon number "..v.Name)
    end
end

autofarms:Toggle("Auto-Feed", false, function(value)
    _G.AutoFeedEnabled = value
    while _G.AutoFeedEnabled do
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SellPad.Main, 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SellPad.Main, 1)
        wait(.5)
    end
end)

autofarms:Toggle("Auto-Collect", false, function(value)
    _G.AutoCollectEnabled = value
    if _G.AutoCollectEnabled then
        local CollectItemAdded = tycoon.ItemDebris.ChildAdded:Connect(function(v)
            if _G.AutoCollectEnabled == false then
                CollectItemAdded:Disconnect()
                return
            end
            game:GetService("ReplicatedStorage"):WaitForChild("RF"):WaitForChild("CollectItem"):InvokeServer(v)
        end)
        for i, v in pairs(tycoon.ItemDebris:GetChildren()) do
            game:GetService("ReplicatedStorage"):WaitForChild("RF"):WaitForChild("CollectItem"):InvokeServer(v)
        end
    end
end)

frenzy:Toggle("Frenzy Time", false, function(value)
    _G.FrenzyTimeEnabled = value
    while _G.FrenzyTimeEnabled do
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Hard Obby"], 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Hard Obby"], 1)
        repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.FDN.TopFrame.BoostHolder.FrenzyTime.Text == "Frenzy Time - x2 Food: 01:00"
        wait(1)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Easy Obby"], 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Easy Obby"], 1)
        repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.FDN.TopFrame.BoostHolder.FrenzyTime.Text == "Frenzy Time - x2 Food: 01:00"
        wait(1)
    end
end)

frenzy:Button("Win Easy Obby", function()
    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Easy Obby"], 0)
    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Easy Obby"], 1)
end)

frenzy:Button("Win Hard Obby", function()
    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Hard Obby"], 0)
    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").ObbyRewardButtons["Hard Obby"], 1)
end)

misc:Button("rejoin", function()
    if #game:GetService("Players"):GetPlayers() <= 1 then
        game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
        wait()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    else
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
end)