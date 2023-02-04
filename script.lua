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
if tycoon == nil then
    library:Notification("Error!", "You don\'t own a tycoon!", "idot")
end

autofarms:Toggle("Auto-Feed", false, function(value)
    _G.AutoFeedEnabled = value
    while _G.AutoFeedEnabled do
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SellPad.Main, 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SellPad.Main, 1)
        wait(.5)
    end
end)

local function removeShit()
    game:GetService("Players").LocalPlayer.PlayerGui.FDN.BuyCashFrame:Destroy()
    game:GetService("Lighting").UIBlur:Destroy()
end

local CollectingItems
autofarms:Toggle("Auto-Collect", false, function(value)
    _G.AutoCollectEnabled = value
    if _G.AutoCollectEnabled then
        pcall(removeShit)
        local function CollectItemAdded(v)
            if _G.AutoCollectEnabled == false then
                CollectingItems:Disconnect()
                return
            end
            game:GetService("ReplicatedStorage"):WaitForChild("RF"):WaitForChild("CollectItem"):InvokeServer(v)
        end
        CollectingItems = tycoon.ItemDebris.ChildAdded:Connect(CollectItemAdded)
        for i, v in pairs(tycoon.ItemDebris:GetChildren()) do
            game:GetService("ReplicatedStorage"):WaitForChild("RF"):WaitForChild("CollectItem"):InvokeServer(v)
        end
    end
end)

local currentButton = 1
autofarms:Toggle("Auto-Purchase", false, function(value)
    _G.AutoPurchaseEnabled = value
    while _G.AutoPurchaseEnabled do
        pcall(removeShit)
        while tycoon.DropperButtons:FindFirstChild(tostring(currentButton)) == nil do
            currentButton = currentButton + 1
            if currentButton == 90 then
                currentButton = 1
            end
            print("current button is "..tostring(currentButton))
        end
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.DropperButtons:FindFirstChild(tostring(currentButton)).Main, 1)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.DropperButtons:FindFirstChild(tostring(currentButton)).Main, 0)
        wait(0.15)
    end
end)

local currentSpeedUpgrade
autofarms:Toggle("Auto-Speed-Upgrade", false, function(value)
    _G.AutoSpeedUpgradeEnabled = value
    while _G.AutoSpeedUpgradeEnabled do
        pcall(removeShit)
        currentSpeedUpgrade = 1
        while tycoon.SpeedUpgrades:FindFirstChild(tostring(currentSpeedUpgrade)) == nil do currentSpeedUpgrade = currentSpeedUpgrade + 1 end
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SpeedUpgrades:FindFirstChild(tostring(currentSpeedUpgrade)).Main, 1)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.SpeedUpgrades:FindFirstChild(tostring(currentSpeedUpgrade)).Main, 0)
        wait(0.15)
    end
end)

autofarms:Toggle("Auto-Rebirth", false, function(value)
    _G.AutoRebirthEnabled = value
    while _G.AutoRebirthEnabled do
        pcall(removeShit)
        if tycoon.Unlockables:FindFirstChild("RebirthStatue") then
            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.Unlockables:FindFirstChild("RebirthStatue").Main, 1)
            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tycoon.Unlockables:FindFirstChild("RebirthStatue").Main, 0)
        end
        if tycoon.Unlocked:FindFirstChild("RebirthStatue") and tycoon.Unlocked:FindFirstChild("RebirthStatue"):FindFirstChild("RebirthPart") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = tycoon.Unlocked.RebirthStatue.RebirthPart.CFrame
            fireproximityprompt(tycoon.Unlocked:FindFirstChild("RebirthStatue"):FindFirstChild("RebirthPart"):FindFirstChildOfClass("ProximityPrompt"))
        end
        wait(0.1)
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

misc:Button("Rejoin", function()
    if #game:GetService("Players"):GetPlayers() <= 1 then
        game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
        wait()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    else
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
end)

local Noclipping

misc:Toggle("Noclip", false, function(value)
	wait(0.1)
	local function NoclipLoop()
		if value == true and game:GetService("Players").LocalPlayer.Character ~= nil then
			for _, child in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		else
            Noclipping:Disconnect()
        end
	end
	Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)
end)