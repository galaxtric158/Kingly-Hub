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
    DiscordInvite = "jR8Yt7cbq9", -- i dont have a discord server haha
	Icon = 1, --
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
local Label = Settings:CreateLabel({
	Text = "Warning! Themes currently do not work.", -- rn themes arent correctly implemented in luna's api. gotta wait for a patch (future galax pls update ts)
	Style = 3
})

Settings:BuildThemeSection()




-- universal script stuff

Universal:CreateSection("Player")
-- walkspeed
local Slider = Universal:CreateSlider({
    Name = "WalkSpeed Slider",
    Range = {16, 1000}, -- the min and max values
    Increment = 1, -- the changing values/rounding offs
    CurrentValue = 16, -- The Starting Value
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        -- Function to set the walk speed
        local function setWalkSpeed(speedValue)
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                humanoid.WalkSpeed = speedValue
            else
                Luna:Notification({
                    Title = "Warning!",
                    Icon = "error",
                    ImageSource = "Material",
                    Content = "Character or Humanoid not found yet."
                })
            end
        end

        -- Set the walk speed immediately when the slider changes
        setWalkSpeed(Value)
    end
}, "Slider")

-- jump power slider

local Slider = Universal:CreateSlider({
    Name = "Jump Power Slider",
    Range = {50, 500},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        -- Function to set the jump power
        local function setJumpPower(powerValue)
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                humanoid.JumpPower = powerValue
            else
                Luna:Notification({
                    Title = "Warning!",
                    Icon = "error",
                    ImageSource = "Material",
                    Content = "Character or Humanoid not found yet."
                })
            end
        end

        -- Set the jump power immediately when the slider changes
        setJumpPower(Value)
    end
}, "JumpPowerSlider")


-- scripts
Universal:CreateSection("Scripts")

local Button = Universal:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Loads the script Infinite Yield.", -- an admin script thing idk broo
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    	end
})

local Button = Universal:CreateButton({
	Name = "Load ESP",
	Description = "Loads an ESP script.", -- esp wowo
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
    	end
})

Universal:CreateSection("Fisch")
local Button = Universal:CreateButton({
	Name = "Load Speed Hub X",
	Description = "Loads the script hub Speed Hub X.", -- fisch
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    	end
})

-- readme stuff
local Label = ReadMe:CreateLabel({
	Text = "Information",
	Style = 2
})

local Paragraph = ReadMe:CreateParagraph({
	Title = "Hey!",
	Text = "Thanks for using Kingly Hub! This is the universal version, meaning it will work on any game! (that is not automatically supported by Kingly.)"
})

local Paragraph = ReadMe:CreateParagraph({
	Title = "Supported Games",
	Text = "Kingly currently supports: The Strongest Battlegrounds."
})

local Paragraph = ReadMe:CreateParagraph({
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


