--	                                                                  ,---. 
--	 ,--. ,--.,--.               ,--.         ,--.  ,--.        ,--.   |   | 
--	 |  .'   /`--',--,--,  ,---. |  |,--. ,--.|  '--'  |,--.,--.|  |-. |  .' 
--	 |  .   ' ,--.|      \| .-. ||  | \  '  / |  .--.  ||  ||  || .-. '|  |  
--	 |  |\   \|  ||  ||  |' '-' '|  |  \   '  |  |  |  |'  ''  '| `-' |`--'  
--	 `--' '--'`--'`--''--'.`-  / `--'.-'  /   `--'  `--' `----'  `---' .--.  
--	                     `---'      `---'                             '--'  
-- 	UPDATE 1.1; 
-- 	 - Removed the option for different script hubs. (no advertising here haha)
-- 	 - Added an option to server hop, rejoin servers, test unc, and added DarkDex
--	 - Added more notifications haha funny (for loading scripts)
--  	 - fixed some bugs with notifications

local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Kingly Hub",
	Subtitle = "Universal Edition!",
	LogoID = "82795327169782",
	LoadingEnabled = true,
	LoadingTitle = "Kingly Hub",
	LoadingSubtitle = "Universal Edition; Made by galaxtric158",
	ConfigSettings = {
		ConfigFolder = "Kingly Hub"
	},
})

-- TAB CREATION
Window:CreateHomeTab({
	SupportedExecutors = {},
    DiscordInvite = "jR8Yt7cbq9",
	Icon = 1,
})

local ReadMe = Window:CreateTab({
	Name = "Read Me!",
	Icon = "description",
	ImageSource = "Material",
	ShowTitle = true
})

local Universal = Window:CreateTab({
	Name = "Universal Scripts",
	Icon = "account_circle",
	ImageSource = "Material",
	ShowTitle = true
})

local Settings = Window:CreateTab({
	Name = "Settings",
	Icon = "settings",
	ImageSource = "Material",
	ShowTitle = true
})

-- settings stuff
Settings:BuildThemeSection()

-- universal script stuff
Universal:CreateSection("Player")

-- walkspeed
Universal:CreateSlider({
    Name = "WalkSpeed Slider",
    Range = {16, 1000},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local function setWalkSpeed(speedValue)
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
            else
                Luna:Notification({
                    Title = "Warning!",
                    Icon = "error",
                    ImageSource = "Material",
                    Content = "Character or Humanoid not found yet."
                })
            end
        end
        setWalkSpeed(Value)
    end
}, "Slider")

-- jump power slider
Universal:CreateSlider({
    Name = "Jump Power Slider",
    Range = {50, 500},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local function setJumpPower(powerValue)
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = powerValue
            else
                Luna:Notification({
                    Title = "Warning!",
                    Icon = "error",
                    ImageSource = "Material",
                    Content = "Character or Humanoid not found yet."
                })
            end
        end
        setJumpPower(Value)
    end
}, "JumpPowerSlider")

-- Noclip toggle inside the "Player" section in the Universal tab
local noclipEnabled = false

-- Add the toggle to the Universal tab
Universal:CreateToggle({
    Name = "Toggle Noclip",
    CurrentValue = false,
    Callback = function(Value)
        noclipEnabled = Value
        if noclipEnabled then
            -- Activate Noclip
            local Workspace = game:GetService("Workspace")
            local Players = game:GetService("Players")
            local Plr = Players.LocalPlayer
            local Stepped
            local Clipon = true

            -- Noclip script logic
            Stepped = game:GetService("RunService").Stepped:Connect(function()
                if not Clipon then
                    return
                end
                for _, b in pairs(Workspace:GetChildren()) do
                    if b.Name == Plr.Name then
                        for _, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            end)

            -- Update Status Text
            Luna:Notification({
                Title = "Noclip Enabled",
                Icon = "directions_run",
                ImageSource = "Material",
                Content = "Noclip is now active."
            })

        else
            -- Deactivate Noclip
            Clipon = false
            Luna:Notification({
                Title = "Noclip Disabled",
                Icon = "directions_walk",
                ImageSource = "Material",
                Content = "Noclip is turned off."
            })
        end
    end
})



-- Fly section
Universal:CreateSection("Fly")

local flying = false
local flyVelocity, flyGyro = nil, nil
local flySpeed = 75
local keysDown = {}
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		keysDown[input.KeyCode] = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		keysDown[input.KeyCode] = false
	end
end)

local function getDirectionVector()
	local move = Vector3.zero
	if keysDown[Enum.KeyCode.W] then move = move + Vector3.new(0, 0, -1) end
	if keysDown[Enum.KeyCode.S] then move = move + Vector3.new(0, 0, 1) end
	if keysDown[Enum.KeyCode.A] then move = move + Vector3.new(-1, 0, 0) end
	if keysDown[Enum.KeyCode.D] then move = move + Vector3.new(1, 0, 0) end
	if keysDown[Enum.KeyCode.Q] then move = move + Vector3.new(0, 1, 0) end
	if keysDown[Enum.KeyCode.Space] then move = move + Vector3.new(0, 1, 0) end
	if keysDown[Enum.KeyCode.E] then move = move + Vector3.new(0, -1, 0) end
	return move
end

local function startFly()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	flyVelocity = Instance.new("BodyVelocity")
	flyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1e5
	flyVelocity.Velocity = Vector3.zero
	flyVelocity.Name = "FlyVelocity"
	flyVelocity.Parent = hrp

	flyGyro = Instance.new("BodyGyro")
	flyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e6
	flyGyro.P = 1e4
	flyGyro.CFrame = hrp.CFrame
	flyGyro.Name = "FlyGyro"
	flyGyro.Parent = hrp

	RunService:BindToRenderStep("FlyUpdate", Enum.RenderPriority.Character.Value + 1, function()
		local moveDir = getDirectionVector()
		if moveDir.Magnitude > 0 then
			local camCF = workspace.CurrentCamera.CFrame
			local moveVec = camCF:VectorToWorldSpace(moveDir.Unit)
			flyVelocity.Velocity = moveVec * flySpeed
			flyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + moveVec)
		else
			flyVelocity.Velocity = Vector3.zero
		end
	end)
end

local function stopFly()
	local char = game.Players.LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		if flyVelocity then flyVelocity:Destroy() flyVelocity = nil end
		if flyGyro then flyGyro:Destroy() flyGyro = nil end
	end
	RunService:UnbindFromRenderStep("FlyUpdate")
end

Universal:CreateSlider({
	Name = "Fly Speed",
	Range = {25, 1000},
	Increment = 5,
	CurrentValue = 75,
	Callback = function(Value)
		flySpeed = Value
	end
}, "FlySpeedSlider")

Universal:CreateToggle({
	Name = "Toggle Fly",
	CurrentValue = false,
	Callback = function(Value)
		flying = Value
		if flying then
			startFly()
			Luna:Notification({
				Title = "Fly Enabled",
				Icon = "flight_takeoff",
				ImageSource = "Material",
				Content = "Use WASD + Q or Space/E to fly."
			})
		else
			stopFly()
			Luna:Notification({
				Title = "Fly Disabled",
				Icon = "flight_land",
				ImageSource = "Material",
				Content = "Flight mode turned off."
			})
		end
	end
})

Universal:CreateSection("Server")

Universal:CreateButton({
	Name = "Server Hop",
	Description = "Change your current server.",
	Callback = function()
		    Luna:Notification({
			Title = "Hopping Servers..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Hopping servers.. Please wait.."
		})
		local TeleportService = game:GetService("TeleportService")
		local HttpService = game:GetService("HttpService")
		
		local Servers = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
		local Server, Next = nil, nil
		local function ListServers(cursor)
		    local Raw = game:HttpGet(Servers .. ((cursor and "&cursor=" .. cursor) or ""))
		    return HttpService:JSONDecode(Raw)
		end
		
		repeat
		    local Servers = ListServers(Next)
		    Server = Servers.data[math.random(1, (#Servers.data / 3))]
		    Next = Servers.nextPageCursor
		until Server
		
		if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
		    TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, game.Players.LocalPlayer)
		end
	end
})

Universal:CreateButton({
    Name = "Rejoin Server",
    Description = "Rejoin your current server.",
    Callback = function()
	    Luna:Notification({
		Title = "Rejoining Server..",
		Icon = "refresh",
		ImageSource = "Material",
		Content = "Rejoining server.. Please wait.."
				})
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
    end
})

-- scripts
Universal:CreateSection("Scripts")

Universal:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Loads the script Infinite Yield.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading Infinite Yield..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Infinite Yield, an admin panel script..."
				})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		Luna:Notification({ 
			Title = "Loaded Infinite Yield!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded Infinite Yield!"
		})
	end
})

Universal:CreateButton({
    Name = "Load DarkDex",
    Description = "Loads DarkDex, a Roblox Studio explorer.",
    Callback = function()
	Luna:Notification({ 
		Title = "Loading DarkDex..",
		Icon = "refresh",
		ImageSource = "Material",
		Content = "Loading DarkDex, a Roblox Studio Explorer..."
			})
	loadstring(game:HttpGet("https://raw.githubusercontent.com/AlterX404/DarkDEX-V5/refs/heads/main/DarkDEX-V5", true))()
		Luna:Notification({ 
			Title = "Loaded DarkDex!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "Your successfully loaded DarkDex!"
				})
    end
})

Universal:CreateButton({
	Name = "Load ESP",
	Description = "Loads an ESP script.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading ESP..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Unammed ESP..."
				})
		wait(1.2)
		Luna:Notification({ 
			Title = "Loaded ESP!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded ESP!"
		})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()

	end
})

Universal:CreateButton({
	Name = "Load Aimbot V3",
	Description = "Loads an aimbot script made by Exunys.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading Aimbot V3..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Aimbot V3 by Exunys..."
				})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))() 
		Luna:Notification({ 
			Title = "Loaded Aimbot!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded Aimbot V3, all credits goes to Exunys!"
		})
	end
})

Universal:CreateButton({
	Name = "Load ChatTracker",
	Description = "Loads a ChatTracker script.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading ChatTracker..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading ChatTracker..."
				})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/v-oidd/chat-tracker/main/chat-tracker.lua"))() 
		Luna:Notification({ 
			Title = "Loaded ChatTracker!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded ChatTracker."
		})
	end
})

-- Universal:CreateButton({
--     Name = "Load HatHub",
--     Description = "Loads the FE script HatHub.",
--     Callback = function()
--         loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/hat-scripts/refs/heads/main/updatedhathub.lua"))()
--         Luna:Notification({ 
--             Title = "Loaded HatHub!",
--             Icon = "check_circle",
--             ImageSource = "Material",
--             Content = "You successfully loaded HatHub!"
--         })

Universal:CreateSection("Executor Tests")

Universal:CreateButton({
	Name = "Test your UNC, sUNC, and figure out your 'Skid-Meter.'",
	Description = "Test your executors environment.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading CET..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Cherry Environment Test..."
				})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Executor-Tests/refs/heads/main/Environment/Test.lua"))()
		Luna:Notification({ 
			Title = "Loaded CET!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully Cherry Environment Test, Click F9 on your keyboard to check the test results. all credits goes to the InfernusScripts on GitHub!"
		})
	end
})

-- readme sh*t
ReadMe:CreateLabel({
	Text = "Information",
	Style = 2
})

ReadMe:CreateParagraph({
	Title = "Hey!",
	Text = "Thanks for using Kingly Hub!\n\nThis UI supports both regular and universal scripts. You can load various tools, including Infinite Yield, ESP, Aimbot, DarkDex, and more!\n\nFeel free to explore and have fun!"
})

Luna:Notification({ 
	Title = "Loaded Kingly Hub!",
	Icon = "check_circle",
	ImageSource = "Material",
	Content = "You successfully loaded Kingly Universal Hub."
	})
