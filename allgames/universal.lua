--	                                                                  ,---. 
--	 ,--. ,--.,--.               ,--.         ,--.  ,--.        ,--.   |   | 
--	 |  .'   /`--',--,--,  ,---. |  |,--. ,--.|  '--'  |,--.,--.|  |-. |  .' 
--	 |  .   ' ,--.|      \| .-. ||  | \  '  / |  .--.  ||  ||  || .-. '|  |  
--	 |  |\   \|  ||  ||  |' '-' '|  |  \   '  |  |  |  |'  ''  '| `-' |`--'  
--	 `--' '--'`--'`--''--'.`-  / `--'.-'  /   `--'  `--' `----'  `---' .--.  
--	                     `---'      `---'                             '--'  
-- 	UPDATE v2.0 :
-- 	 - Removed the option for different script hubs.
-- 	 - Added an option to server hop, rejoin servers.
--	 - Added more notifications haha funny (for loading scripts)
--  	 - Fixed some bugs with notifications and how they are displayed and such.
--  	 - Added flight script.
-- 	 - Added teleport to coordinates and to player.
--	 - Added a seperate tab for scripts
--	 - Added more scripts in the scripts tab such as DarkDex, Cherry Environment Test, and more.
-- 	 - Added config.
-- 	 - Added display tab.
--	 - Added (and fixed) a noclip function.
-- 	 - Added a spectate player function.
--	 - Added an anti-afk toggle.
--	 - Added a spin-bot.

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
	Name = "Player",
	Icon = "account_circle",
	ImageSource = "Material",
	ShowTitle = true
})

local ScriptsTab = Window:CreateTab({
	Name = "Scripts",
	Icon = "code",
	ImageSource = "Material",
	ShowTitle = true
})

local Settings = Window:CreateTab({
	Name = "Settings",
	Icon = "settings",
	ImageSource = "Material",
	ShowTitle = true
})

local Config = Window:CreateTab({
	Name = "Configurations",
	Icon = "build",
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

-- place these *outside* your CreateToggle call, so they persist across toggles
local RunService = game:GetService("RunService")
local Players    = game:GetService("Players")
local noclipConn = nil

Universal:CreateToggle({
    Name         = "Toggle Noclip",
    CurrentValue = false,
    Callback     = function(enabled)
        local player = Players.LocalPlayer
        local char   = player.Character or player.CharacterAdded:Wait()

        if enabled then
            -- turn ON: connect a single Stepped callback
            noclipConn = RunService.Stepped:Connect(function()
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)

            Luna:Notification({
                Title   = "Noclip Enabled",
                Icon    = "directions_run",
                Content = "You can now walk through walls."
            })
        else
            -- turn OFF: disconnect the event
            if noclipConn then
                noclipConn:Disconnect()
                noclipConn = nil
            end

            -- optional: restore collisions
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end

            Luna:Notification({
                Title   = "Noclip Disabled",
                Icon    = "directions_walk",
                Content = "Collision restored."
            })
        end
    end
})


 Universal:CreateSection("Teleportation and Other Players")

 local targetCoordinatesString = "" -- Variable to store the coordinate input string

 -- Input field for coordinates
 Universal:CreateInput({
     Name = "Teleport Coordinates",
     Description = "Enter coordinates in 'X, Y, Z' format.",
     PlaceholderText = "e.g., 0, 100, 0",
     CurrentValue = "", -- Start empty
     Numeric = false, -- Allow commas and spaces
     MaxCharacters = 60, -- Limit input length reasonably
     Enter = false, -- Callback triggers on change, not just Enter key
     Callback = function(Text)
         -- Update the stored coordinate string whenever the input changes
         targetCoordinatesString = Text
     end
 }, "TeleportCoordsInput") -- Unique flag for config saving

 -- Button to trigger the teleport
 -- Notifications for different errors are quite uneccecary.
 -- They do not display properly, but thats okay haha.
 Universal:CreateButton({
     Name = "Teleport to Coordinates",
     Description = "Moves your character to the specified X, Y, Z location.",
     Callback = function()
         -- Check if the input string is empty or nil
         if not targetCoordinatesString or targetCoordinatesString == "" then
             Luna:Notification({
                 Title = "Input Error",
                 Icon = "error_outline", -- Material icon for error
                 ImageSource = "Material",
                 Content = "Please enter coordinates in the input box first."
             })
             return -- Stop execution if no coordinates are entered
         end

         -- Attempt to parse the coordinates using string.match
         -- Pattern expects: optional spaces, number, comma, number, comma, number, optional spaces
         -- Allows for optional negative signs and decimal points
         local xStr, yStr, zStr = string.match(targetCoordinatesString, "^%s*(-?%d+%.?%d*)%s*,%s*(-?%d+%.?%d*)%s*,%s*(-?%d+%.?%d*)%s*$")

         -- Check if the pattern matched successfully
         if not xStr or not yStr or not zStr then
             Luna:Notification({
                 Title = "Format Error",
                 Icon = "error", -- Material icon for error
                 ImageSource = "Material",
                 Content = "Invalid format. Please use 'X, Y, Z' (e.g., 10, 50.5, -20)."
             })
             return -- Stop execution if format is wrong
         end

         -- Convert the extracted strings to numbers
         local x, y, z = tonumber(xStr), tonumber(yStr), tonumber(zStr)

         -- Double-check if conversion to numbers was successful
         if not x or not y or not z then
              Luna:Notification({
                 Title = "Parsing Error",
                 Icon = "error",
                 ImageSource = "Material",
                 Content = "Could not convert extracted coordinates to numbers. Check input."
             })
             return -- Stop execution if conversion failed
         end

         -- If parsing and conversion are successful, proceed with teleportation
         local Players = game:GetService("Players")
         local LocalPlayer = Players.LocalPlayer
         local Character = LocalPlayer.Character
         local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

         if HumanoidRootPart then
             -- Create the target position Vector3
             local targetPosition = Vector3.new(x, y, z)
             -- Set the CFrame of the HumanoidRootPart to the target position
             HumanoidRootPart.CFrame = CFrame.new(targetPosition)

             Luna:Notification({
                 Title = "Teleport Successful",
                 Icon = "place", -- Material icon for success
                 ImageSource = "Material",
                 Content = "Teleported to coordinates; " .. targetCoordinatesString
             })
         else
             -- Notify the user if the character or HumanoidRootPart can't be found
             Luna:Notification({
                 Title = "Teleport Failed",
                 Icon = "warning", -- Material icon for warning
                 ImageSource = "Material",
                 Content = "Could not find your character's HumanoidRootPart. Character might not be loaded yet."
             })
         end
     end
 })

local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


-- keep track of the choice
local selectedPlayerName = LocalPlayer.Name

-- build initial list of names
local function getPlayerNames()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        table.insert(names, plr.Name)
    end
    return names
end

Universal:CreateDivider()
-- create the dropdown
local playerDropdown = Universal:CreateDropdown({
    Name           = "Player to Select",
    Description    = "Select a player",
    Options        = getPlayerNames(),
    CurrentOption  = LocalPlayer.Name,
    MultipleOptions= false,
    SpecialType    = nil,
    Callback       = function(choice)
        selectedPlayerName = choice
    end,
}, "TeleportToPlayer")

-- function to refresh dropdown whenever players join/leave
local function refreshDropdown()
    local names = getPlayerNames()
    -- update both the options list and keep the same selection if still present
    playerDropdown:Set({
        Options       = names,
        CurrentOption = table.find(names, selectedPlayerName) and selectedPlayerName or LocalPlayer.Name,
    })
end

-- connect events
Players.PlayerAdded:Connect(refreshDropdown)
Players.PlayerRemoving:Connect(refreshDropdown)

-- initial populate
refreshDropdown()

-- create the teleport button
Universal:CreateButton({
    Name        = "Teleport to Player",
    Description = "Teleport to the selected player",
    Callback    = function()
        local target = Players:FindFirstChild(selectedPlayerName)
        local hrp = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- teleport your HRP to theirs
            LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame
            Luna:Notification({
                Title   = "Teleported!",
                Icon    = "place",
                Content = "You are now with " .. selectedPlayerName
            })
        else
            Luna:Notification({
                Title   = "Teleport Failed",
                Icon    = "warning",
                Content = "Could not find HumanoidRootPart for " .. selectedPlayerName
            })
        end
    end,
})

local camera            = workspace.CurrentCamera
local originalSubject   = camera.CameraSubject
local originalCamType   = camera.CameraType

Universal:CreateToggle({
    Name         = "Spectate Player",
    CurrentValue = false,
    Callback     = function(enabled)
        -- Find the target player and their Humanoid
        local targetPlayer = Players:FindFirstChild(selectedPlayerName)
        local targetHumanoid = targetPlayer
            and targetPlayer.Character
            and targetPlayer.Character:FindFirstChildWhichIsA("Humanoid")

        if enabled then
            if targetHumanoid then
                -- Store original camera settings
                originalSubject = camera.CameraSubject
                originalCamType = camera.CameraType

                -- Switch to spectate subject
                camera.CameraSubject = targetHumanoid
                camera.CameraType    = Enum.CameraType.Custom

                Luna:Notification({
                    Title   = "Spectating",
                    Icon    = "visibility",
                    Content = "Now spectating " .. selectedPlayerName
                })

                -- Restore when the target dies
                targetHumanoid.Died:Connect(function()
                    if camera then
                        camera.CameraSubject = originalSubject
                        camera.CameraType    = originalCamType
                    end
                end)
            else
                Luna:Notification({
                    Title   = "Spectate Failed",
                    Icon    = "warning",
                    Content = "Could not find '" .. selectedPlayerName .. "' to spectate."
                })
            end
        else
            -- Stop spectating: restore the original camera
            camera.CameraSubject = originalSubject or Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            camera.CameraType    = originalCamType    or Enum.CameraType.Custom

            Luna:Notification({
                Title   = "Stopped Spectating",
                Icon    = "visibility_off",
                Content = "Camera restored."
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

Universal:CreateSection("Utilities")
Universal:CreateButton({
	Name = "Display Ping",
	Description = "Display your current server ping in the top left.",
	Callback = function()
		    Luna:Notification({
			Title = "Loading..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading ping GUI, please wait.."
				})
		local Players    = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local Stats      = game:GetService("Stats")
		
		-- 2) Player + Ping stat
		local player     = Players.LocalPlayer
		-- this is where Roblox stores “Data Ping” (in ms as a string)
		local pingStat   = Stats.Network.ServerStatsItem:FindFirstChild("Data Ping")
		
		-- 3) Build your ScreenGui + TextLabel
		local gui = Instance.new("ScreenGui")
		gui.Name   = "PingDisplay"
		gui.ResetOnSpawn = false
		gui.Parent = player:WaitForChild("PlayerGui")
		
		local txt = Instance.new("TextLabel")
		txt.Parent               = gui
		txt.Position             = UDim2.new(0, 70, 0, 10)
		txt.Size                 = UDim2.new(0, 150, 0, 30)
		txt.BackgroundTransparency = 1
		txt.TextColor3            = Color3.new(1, 1, 1)
		txt.TextStrokeTransparency= 0
		txt.FontSize             = Enum.FontSize.Size18
		txt.Text                 = "Ping: 0 ms"
		
		-- 4) Update loop
		RunService.RenderStepped:Connect(function()
		    if pingStat then
		        -- Data Ping exists, use its built-in GetValueString()
		        txt.Text = "Ping: " .. pingStat:GetValueString()
		    else
		        -- fallback: Player:GetNetworkPing() returns seconds
		        local ms = math.floor(player:GetNetworkPing() * 1000)
		        txt.Text = ("Ping: %d ms"):format(ms)
		    end
		end)
		
		    Luna:Notification({
			Title = "Loaded!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "Loaded ping GUI!"
				})


	end
})

Universal:CreateButton({
	Name = "Display FPS",
	Description = "Display your current server FPS in the top right.",
	Callback = function()
		    Luna:Notification({
			Title = "Loading..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading FPS GUI, please wait.."
				})
			-- Services
			local Players    = game:GetService("Players")
			local RunService = game:GetService("RunService")
			
			-- Player GUI
			local player = Players.LocalPlayer
			
			-- Create a ScreenGui that survives respawn
			local gui = Instance.new("ScreenGui")
			gui.Name         = "StatsDisplay"
			gui.ResetOnSpawn = false
			gui.Parent       = player:WaitForChild("PlayerGui")
			
			-- Create the FPS TextLabel
			local fpsLabel = Instance.new("TextLabel")
			fpsLabel.Name                 = "FPSLabel"
			fpsLabel.Parent               = gui
			fpsLabel.AnchorPoint          = Vector2.new(1, 0)          -- anchor to top-right
			fpsLabel.Position             = UDim2.new(1, -10, 0, 10)   -- 10px from right, 10px from top
			fpsLabel.Size                 = UDim2.new(0, 150, 0, 25)
			fpsLabel.BackgroundTransparency= 1
			fpsLabel.BorderSizePixel      = 0
			fpsLabel.TextColor3           = Color3.new(1, 1, 1)
			fpsLabel.TextStrokeTransparency = 0
			fpsLabel.Font                 = Enum.Font.SourceSansBold
			fpsLabel.TextSize             = 18
			fpsLabel.Text                 = "FPS: 0"
			
			-- FPS calculation variables
			local frameCount = 0
			local elapsed    = 0.0
			
			-- Update loop
			RunService.RenderStepped:Connect(function(dt)
			    frameCount = frameCount + 1
			    elapsed    = elapsed + dt
			
			    if elapsed >= 1 then
			        local fps = math.floor(frameCount / elapsed + 0.5)
			        fpsLabel.Text = "FPS: " .. fps
			
			        -- reset counters
			        frameCount = 0
			        elapsed    = 0
			    end
			end)
			
					
		    Luna:Notification({
			Title = "Loaded!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "Loaded FPS GUI!"
				})


	end
})

Universal:CreateButton({
	Name = "Low Quality Mode",
	Description = "Removes most textures.",
	Callback = function()
		    Luna:Notification({
			Title = "Loading..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Please wait.."
				})

			
			--Remove FPS cap
			setfpscap(9999)
			-- Lower Terrain Settings
			local terrain = workspace:FindFirstChildOfClass("Terrain")
			if terrain then
			    terrain.WaterWaveSize = 0
			    terrain.WaterWaveSpeed = 0
			    terrain.WaterReflectance = 0
			    terrain.WaterTransparency = 1
			end
			
			-- Lighting Settings
			local lighting = game:GetService("Lighting")
			lighting.GlobalShadows = false
			lighting.FogEnd = math.huge
			lighting.Brightness = 0
			
			-- Remove Textures, Decals, Particles
			for _, obj in pairs(workspace:GetDescendants()) do
			    if obj:IsA("Decal") or obj:IsA("Texture") then
			        obj:Destroy()
			    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
			        obj:Destroy()
			    end
			end
			
			-- Change All Parts to SmoothPlastic
			for _, part in pairs(workspace:GetDescendants()) do
			    if part:IsA("BasePart") then
			        part.Material = Enum.Material.SmoothPlastic
			    end
			end

					
		    Luna:Notification({
			Title = "Loaded!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "Loaded everything."
				})


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

Universal:CreateButton({
	Name = "Copy Game ID",
	Description = "Copies the game's placeID.",
	Callback = function()
		setclipboard(tostring(game.PlaceId))
		Luna:Notification({ 
			Title = "Copied Game ID!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully copied this game's placeID!"
		})
	end
})

Universal:CreateSection("Misc")

local spinBotEnabled = false
local spinBotSpeed   = 20
local spinBotConn

Universal:CreateToggle({
    Name         = "Spin Bot",
    CurrentValue = spinBotEnabled,
    Callback     = function(enabled)
        spinBotEnabled = enabled
        local player    = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp       = character:FindFirstChild("HumanoidRootPart")
        if enabled then
            character.Humanoid.AutoRotate = false
            spinBotConn = RunService.RenderStepped:Connect(function()
                if hrp then
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinBotSpeed), 0)
                end
            end)
        else
            if spinBotConn then spinBotConn:Disconnect() spinBotConn = nil end
            character.Humanoid.AutoRotate = true
        end
    end
}, "SpinBotToggle")

Universal:CreateSlider({
    Name         = "Spin Speed",
    Range        = {10, 5000},
    Increment    = 5,
    CurrentValue = spinBotSpeed,
    Callback     = function(val)
        spinBotSpeed = val
    end
}, "SpinBotSpeed")


-- Anti-AFK toggle
local VirtualUser    = game:GetService("VirtualUser")
local antiAfkConn

Universal:CreateToggle({
    Name         = "Anti-AFK",
    CurrentValue = false,
    Callback     = function(enabled)
        if enabled then
            -- connect to the LocalPlayer.Idled event to simulate a click
            antiAfkConn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
            Luna:Notification({
                Title   = "Anti-AFK Enabled",
                Icon    = "check",
                Content = "You will no longer be kicked for idling."
            })
        else
            -- disconnect when turned off
            if antiAfkConn then
                antiAfkConn:Disconnect()
                antiAfkConn = nil
            end
            Luna:Notification({
                Title   = "Anti-AFK Disabled",
                Icon    = "close",
                Content = "AFK kick is back on."
            })
        end
    end
}, "AntiAFKToggle")





ScriptsTab:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Loads the script Infinite Yield, an admin panel script.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading Infinite Yield..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Infinite Yield, an admin panel script..."
				})
		loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
		Luna:Notification({ 
			Title = "Loaded Infinite Yield!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded Infinite Yield!"
		})
	end
})

ScriptsTab:CreateButton({
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

ScriptsTab:CreateButton({
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

ScriptsTab:CreateButton({
	Name = "Load Aimbot V3",
	Description = "Loads an aimbot script made by Exunys.",
	Callback = function()
		Luna:Notification({ 
			Title = "Loading Aimbot V3..",
			Icon = "refresh",
			ImageSource = "Material",
			Content = "Loading Aimbot V3 by Exunys..."
				})
		local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
		Aimbot.Load()
		Luna:Notification({ 
			Title = "Loaded Aimbot!",
			Icon = "check_circle",
			ImageSource = "Material",
			Content = "You successfully loaded Aimbot V3, all credits goes to Exunys!"
		})
	end
})

ScriptsTab:CreateButton({
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

-- disabled cause unstable and bad
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

ScriptsTab:CreateSection("Executor Tests")

ScriptsTab:CreateButton({
	Name = "Test your UNC and sUNC.",
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
			Content = "You successfully loaded Cherry Environment Test, Click F9 on your keyboard to check the test results. all credits goes to the InfernusScripts on GitHub!"
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
	Text = "Thanks for using Kingly Hub!\n\nThis UI/script hub supports both regular and universal scripts. You can load various tools, including Infinite Yield, ESP, Aimbot, DarkDex, and more!\n\nFeel free to explore and have fun! (or cheat lmao)"
})



local success, err = pcall(function()
    Luna:Notification({ 
	Title = "Loaded Kingly Hub!",
	Icon = "check_circle",
	ImageSource = "Material",
	Content = "You successfully loaded Kingly Universal Hub."
	})
end)
if not success then
    Luna:Notification({
        Title = "Error",
        Icon = "error",
        ImageSource = "Material",
        Content = "Failed to load script: " .. err
    })
end

Luna:LoadAutoloadConfig()
Config:BuildConfigSection()
