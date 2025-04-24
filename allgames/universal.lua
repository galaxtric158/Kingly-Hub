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
	if keysDown[Enum.KeyCode.Space] then move = move + Vector3.new(0, 1, 0) end
	if keysDown[Enum.KeyCode.LeftControl] then move = move + Vector3.new(0, -1, 0) end
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
				Content = "Use WASD + Space/Ctrl to fly."
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

-- scripts
Universal:CreateSection("Scripts")

Universal:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Loads the script Infinite Yield.",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end
})

Universal:CreateButton({
	Name = "Load ESP",
	Description = "Loads an ESP script.",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
	end
})

Universal:CreateSection("Fisch")

Universal:CreateButton({
	Name = "Load Speed Hub X",
	Description = "Loads the script hub Speed Hub X.",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
})

-- readme stuff
ReadMe:CreateLabel({
	Text = "Information",
	Style = 2
})

ReadMe:CreateParagraph({
	Title = "Hey!",
	Text = "Thanks for using Kingly Hub! This is the universal version, meaning it will work on any game! (that is not automatically supported by Kingly.)"
})

ReadMe:CreateParagraph({
	Title = "Supported Games",
	Text = "Kingly currently supports: The Strongest Battlegrounds."
})

ReadMe:CreateParagraph({
	Title = "Notice!",
	Text = "I do not have a Discord server btw, so dont expect the join discord server button on the home page to work."
})

-- Notification 
Luna:Notification({ 
	Title = "Kingly Hub Loaded!",
	Icon = "notifications_active",
	ImageSource = "Material",
	Content = "Hey! You successfully loaded Kingly Hub."
})
