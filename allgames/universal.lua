local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Kingly Hub",
	Subtitle = "Universal Edition!",
	LogoID = "82795327169782",
	LoadingEnabled = true,
	LoadingTitle = "Kingly Hub",
	LoadingSubtitle = "Universal Edition; Made by galaxtric158",

    
	ConfigSettings = {
		ConfigFolder = "Kingly Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
	},


    
})

-- TAB CREATION

Window:CreateHomeTab({
	SupportedExecutors = {}, -- A Table Of Executors Your Script Supports. Add strings of the executor names for each executor.
    DiscordInvite = "jR8Yt7cbq9", -- The Discord Invite Link. Do Not Include discord.gg/ | Only Include the code.
	Icon = 1, -- By Default, The Icon Is The Home Icon. If You would like to change it to dashboard, replace the interger with 2
})

local ReadMe = Window:CreateTab({
	Name = "Read Me!",
	Icon = "description",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

local Universal = Window:CreateTab({
	Name = "Universal Scripts",
	Icon = "account_circle",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

local Settings = Window:CreateTab({
	Name = "Settings",
	Icon = "settings",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})





-- settings stuff
local Label = Settings:CreateLabel({
	Text = "Warning! Themes currently do not work.", -- rn themes arent correctly implemented in luna's api. gotta wait for a patch (future galax pls update ts)
	Style = 3 -- Luna Labels Have 3 Styles : A Basic Label, A Green Information Label and A Red Warning Label. Look At The Following Image For More Details
})

Settings:BuildThemeSection() -- Tab Should be the name of the tab you are adding this section to.




-- universal script stuff

Universal:CreateSection("Player")
-- walkspeed
local Slider = Universal:CreateSlider({
    Name = "WalkSpeed Slider",
    Range = {16, 1000}, -- The Minimum And Maximum Values Respectively
    Increment = 1, -- Basically The Changing Value/Rounding Off
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
}, "Slider") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

-- jump power slider

local Slider = Universal:CreateSlider({
    Name = "Jump Power Slider",
    Range = {50, 500}, -- The Minimum And Maximum Values Respectively
    Increment = 5, -- Basically The Changing Value/Rounding Off
    CurrentValue = 50, -- The Starting Value
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
}, "JumpPowerSlider") -- Changed the flag to be more descriptive



-- scripts
Universal:CreateSection("Scripts")

local Button = Universal:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Loads the script Infinite Yield.", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
         -- The function that takes place when the button is pressed
    	end
})

local Button = Universal:CreateButton({
	Name = "Load ESP",
	Description = "Loads an ESP script.", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
         -- The function that takes place when the button is pressed
    	end
})

Universal:CreateSection("Games")
local Button = Universal:CreateButton({
	Name = "Load Speed Hub X",
	Description = "Loads the script hub Speed Hub X.", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
         -- The function that takes place when the button is pressed
    	end
})
local Button = Universal:CreateButton({
	Name = "Load Ronix Hub (Fisch)",
	Description = "Loads the script hub Ronix for Fisch.", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/aa63ce25cd44fa60f0b155dcc3593445.lua"))()
         -- The function that takes place when the button is pressed
    	end
})

-- readme stuff
local Label = ReadMe:CreateLabel({
	Text = "Information",
	Style = 2 -- Luna Labels Have 3 Styles : A Basic Label, A Green Information Label and A Red Warning Label. Look At The Following Image For More Details
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


