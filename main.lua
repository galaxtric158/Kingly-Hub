local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()

-- TSBG
if game.PlaceId == 10449761463 then
    local Window = Fluent:CreateWindow({
        Title = "Hub For The Strongest (Kingly Hub)",
        SubTitle = "TSB Edition; v1.0",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
    })

    local ScreenGui = Instance.new("ScreenGui")
    local TextLabel = Instance.new("TextLabel")

    -- Screen Gui
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")


    -- Create a tab
    local Tabs = {
        DescTab = Window:AddTab({ Title = "Read Me!", Icon = "scroll" }),
        Main = Window:AddTab({ Title = "Universal", Icon = "chevrons-left-right" }),
        Movesets = Window:AddTab({ Title = "Movesets", Icon = "user" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }

    local function addButton(tab, title, description, url, dialogContent, callback)
        tab:AddButton({
            Title = title,
            Description = description,
            Callback = function()
                Window:Dialog({
                    Title = "Are you sure?",
                    Content = dialogContent,
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                                local success, err = pcall(function()
                                    if url ~= "" then
                                        loadstring(game:HttpGet(url))()
                                        print("Script loaded successfully: " .. url)
                                    elseif callback then
                                        callback()
                                        print("Custom function executed for: " .. title)
                                    end
                                end)
                                if not success then
                                    print("There was an error in loading the script/function for " .. title .. ": " .. err)
                                end
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                                print("Cancelled the dialog for: " .. title)
                            end
                        }
                    }
                })
            end
        })
    end


    -- read me

    local InterfaceSection = Tabs.DescTab:AddSection("Notice from the dev!")

    Tabs.DescTab:AddParagraph({
        Title = "Hey!",
        Content = "Thanks for using my script hub! I put a lot of effort to creating this, so I thank you, user, for using this little passion project of mine!"
    })

    -- Adding buttons to the Main tab
    addButton(Tabs.Main, "Infinite Yield", "Loads Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Load Infinite Yield (Admin Panel)")
    addButton(Tabs.Main, "Hitbox Expander", "Loads the Hitbox expander", "https://raw.githubusercontent.com/tamarixr/tamhub/main/hitboxexpand.lua", "Loads the Hitbox Expander")
    addButton(Tabs.Main, "ESP", "Loads ESP", "https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP", "Load ESP")
    addButton(Tabs.Main, "FPS Unlocker", "Loads the FPS unlocker", "", "Load POTATO MODE", function() setfpscap(9999) end)


    -- add moveset buttons and stuff
    local InterfaceSection = Tabs.Movesets:AddSection("A notice!")

    Tabs.Movesets:AddParagraph({
        Title = "Notice!",
        Content = "Please note I did not make all of these scripts.\nAll of the credit goes to the respective owners! im so lazy to make good descriptions for allis"
    })

    local InterfaceSection = Tabs.Movesets:AddSection("Movesets")

    addButton(Tabs.Movesets, "Saitama to Gojo v.2", "Loads Gojo v2 animations and VFX, ", 'https://pastebin.com/raw/jZHTybYw', 'This moveset has a custom outfit, all credits goes to i.am.an.agent on Discord.' )
    addButton(Tabs.Movesets, "Saitama to Gojo", "Loads Gojo anims and VFX", 'https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua', 'Load Gojo anims, credits goes to i.am.an.agent on Discord')
    addButton(Tabs.Movesets, "Suiru to Mahito", "Loads Mahito anims and 4 skill is saratov", 'https://raw.githubusercontent.com/GreatestLime4K/mahitotsb/refs/heads/main/Protected_6381580361331378.txt', 'Load Mahito anims')
    addButton(Tabs.Movesets, "Saitama to Hakari", "Loads Hakari anims and VFX", 'https://pastebin.com/raw/eEDYWj8p', 'Load Hakari anims')
    addButton(Tabs.Movesets, "Garou to Goku", "Loads Goku anims", 'https://raw.githubusercontent.com/JayXSama/ray-makk/main/GOKUTSB', 'Load Goku anims')
    addButton(Tabs.Movesets, "Sonic to Chainsaw Man", "Loads Chainsaw man anims and VFX", 'https://gist.githubusercontent.com/GoldenHeads2/0fd8d36993c850f3fac89e5adf793076/raw/ab4f5a42bd0b2e24a32a46301d533ea849ca771c/gistfile1.txt', 'Load Chainsaw Man anims')
    addButton(Tabs.Movesets, "Saitama to Jun", "Loads Jun anims and VFX", 'https://gist.githubusercontent.com/GoldenHeads2/f66279000c58a020e894a6db44914838/raw/62e53e1acacec0b38b43cd0f594292c32e09c39b/gistfile1.txt', 'Load Jun anims')
    addButton(Tabs.Movesets, "Blade master to Sukuna", "Loads Sukuna anims and VFX", 'https://raw.githubusercontent.com/zyrask/Nexus-Base/main/atomic-blademaster%20to%20sukuna', 'Load Sukuna anims')
    addButton(Tabs.Movesets, "Garou to Okarun", "Loads Okarun anims and VFX", 'https://paste.ee/r/Pn4oj', 'Load Okarun anims')
    addButton(Tabs.Movesets, "Garou to Freddy", "Loads Freddy anims and VFX", 'https://pastebin.com/raw/Ft5psDmD', 'Load Freddy anims')
    addButton(Tabs.Movesets, "Garou to Kizaru", "Loads Kixaru anims and VFX", 'https://paste.ee/r/NPnfk', 'Load Kizaru anims and VFX')
    addButton(Tabs.Movesets, "Garou to Angel", "Loads Angel anims and VFX", 'https://paste.ee/r/1HxVZ', '1 skill teleport to heaven .-.')
    addButton(Tabs.Movesets, "Garou to Akaza", "Loads Akaza anims and VFX", 'https://paste.ee/r/zzvAH', 'Cool script')
    addButton(Tabs.Movesets, "Garou to A-train", "Loads A-train anims", 'https://paste.ee/r/AnZ5j', 'Funny script')
    addButton(Tabs.Movesets, "Garou to Mastery Deku", "Loads Deku anims and VFX", 'https://pastebin.com/raw/xKextYP5', 'This script is based off of Deku from My Hero Academia.')
    addButton(Tabs.Movesets, "KJ to JK", "Loads JK  anims and VFX", 'https://raw.githubusercontent.com/NetlessMade/KJ-TO-JK/refs/heads/main/script.lua', 'Only KJ servers? Heh, that stuff doesnt exist anymore..')
    addButton(Tabs.Movesets, "Suiru to trashcan man", "Loads trashcan man  anims and VFX", 'https://pastebin.com/raw/JH7mnC7X', 'quite a troll script lolol')
    addButton(Tabs.Movesets, "Garou to Diddy", "Loads Diddy  anims and VFX", 'https://paste.ee/r/gKC8V', 'DIDDY?!🤨🤨🤨')
    addButton(Tabs.Movesets, "Sonic to Toji", "Loads Toji  anims", 'https://pastebin.com/raw/VQnyWP5D', 'toji toji toji my daddy')
    addButton(Tabs.Movesets, "Saitama to Sans", "Loads Sans anims and VFX", 'https://paste.ee/r/rF9d3', "Doesn't have ult, but has a Gaster Blaster model")
    addButton(Tabs.Movesets, "Saitama to Heian Sukuna", "Loads Heian Sukuna anims and VFX", 'https://raw.githubusercontent.com/damir512/sukunasaitamav1/main/thescript', 'Ultimate has only 3 skills')
    addButton(Tabs.Movesets, "Saitama to JJS Mahito", "Loads Heian Sukuna anims and VFX", 'https://raw.githubusercontent.com/damir512/sukunasaitamav1/main/thescript', 'Ultimate has only 3 skills')
    addButton(Tabs.Movesets, "Saitama to JJS Gojo", "Loads JJS Gojo anims and VFX", 'https://raw.githubusercontent.com/damir512/jjsgojov3/main/SaitamaToGojoV3_SOURCE-obfuscated_2.txt', 'Load full JJS Gojo version')
    addButton(Tabs.Movesets, "Suiru to Deku v2", "Loads Deku anims and VFX", 'https://github.com/aggiealledge/obfuscated-scripts/raw/refs/heads/main/deku%20suiryu%20thingy.txt', 'Have ult anim')
    addButton(Tabs.Movesets, "Blade master to Yuta", "Loads Yuta anims and VFX", 'https://raw.githubusercontent.com/damir512/AtomicToYuta/main/Protected_8122576078506000.txt', 'RIKA!!')
    addButton(Tabs.Movesets, "Saitama to Kashimo", "Loads Kashimo anims and VFX", 'https://raw.githubusercontent.com/damir512/Kashimo/main/Protected_7491278457865044.txt', 'THOR!!')
    addButton(Tabs.Movesets, "Saitama to Gojo sensei", "Loads Gojo sensei anims and VFX", 'https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua', '200% PURPLE!!')
    addButton(Tabs.Movesets, "Saitama to Shinji", "Loads Shinji anims and VFX", 'https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Shinji%20tp%20exploit', 'Has 5 skills')
    addButton(Tabs.Movesets, "Garou to Sukuna", "Loads Sukuna v2 anims and VFX", 'https://rawscripts.net/raw/The-Strongest-Battlegrounds-Garou-to-Sukuna-23069', 'Have Kamutoke')
    addButton(Tabs.Movesets, "Saitama to Choi Jong In", "Loads Choi Jong In anims and VFX", 'https://raw.githubusercontent.com/nil071n/fireman/refs/heads/main/TSB', 'This moveset has a custom outfit')
    addButton(Tabs.Movesets, "Saitama to Sung Jin Woo", "Loads Choi Jong In anims", 'https://raw.githubusercontent.com/nil071n/fireman/refs/heads/main/TSB', 'This moveset has a custom outfit')
    addButton(Tabs.Movesets, "Saitama to Yuji x Sukuna", "Loads Yuji anims and VFX", 'https://pastebin.com/raw/xpptBe4C', 'Ulti turns to Sukuna')
    addButton(Tabs.Movesets, "Suiru, Saitama, Genos, Metal bat to Star ligther", "Loads Start lighter anims and good VFX", 'https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/SG_DEMO.lua', 'Have custom music, 4 mode (that is work on 4 character like a 4 modes), VERY good VFX, and anims, but dont make ult some have characters')
    addButton(Tabs.Movesets, "Sonic to 1x1x1x1 hacker", "Loads 1x1x1x1 anims and VFX", 'https://gist.githubusercontent.com/GoldenHeads2/900e87ffc32f3c740930ccb106dd6abf/raw/358c5bf0f0a6aa25946718288dab006e3ae7e1d4/gistfile1.txt', 'not bad script, but im tired of hacker scripts, but this is Sonic')
    addButton(Tabs.Movesets, "Garou to Troll Garou", "Loads Trol Garou anims", 'https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Void%20Reaper%20Obfuscated.txt', '1 skill void (Saratov), too have Phantom blink and Vibral shift like a trashcan man ')
    addButton(Tabs.Movesets, "Sonic to black Goku", "Loads black Goku anims and VFX", 'https://raw.githubusercontent.com/Nova2ezz/BlackGoku/refs/heads/main/Protected_5687298824595816.lua', '3 skill dont remake. Black? NIGA NIGA NIGA')
    addButton(Tabs.Movesets, "Saitama to Luffy", "Loads Luffy Goku anims", 'https://github.com/aggiealledge/obfuscated-scripts/raw/refs/heads/main/Protected_7732857839120517.txt', 'Dont have VFX and ult. Bad script')
    addButton(Tabs.Movesets, "Garou to KJ", "Loads KJ anims and VFX", 'https://raw.githubusercontent.com/damir512/garoukjv1maybeidk/main/Protected_2460290213750059.txt', 'Bro KJ is already in the game...')
    addButton(Tabs.Movesets, "Saitama to KJ with black figure", "Loads KJ anims and black figure and VFX", 'https://gist.githubusercontent.com/GoldenHeads2/5fe3178dff916f988d319c3bd5e4fc01/raw/b250ee6f967c4e84195a76ab7915fb1d79b53326/gistfile1.txt', 'SCAAARYYYYYY')
    addButton(Tabs.Movesets, "Saitama to Chara", "Loads Chara anims and VFX", 'https://paste.ee/r/0yYkO', 'temy! tubap tubap tubap tuddi bap')
    addButton(Tabs.Movesets, "Saitama to True Nokotan", "Loads True Nokotan anims and VFX", 'https://raw.githubusercontent.com/JayXSama/ray-makk/refs/heads/main/True%20Nosakatan', 'A life of gambling allways comes with Nokotan')
    

    -- settings buttons
    local InterfaceSection = Tabs.Settings:AddSection("Interface")

    Tabs.Settings:AddDropdown("ThemeSelector", {
        Title = "Select Theme",
        Description = "Choose your preferred UI theme.",
        Values = { "Dark", "Darker", "AMOLED", "Light", "Balloon", "SoftCream", "Aqua", "Amethyst", "Rose", "Midnight", "Forest", "Sunset", "Ocean", "Emerald", "Sapphire", "Cloud", "Grape", "Bloody" },
        Default = "Dark",
        Callback = function(selectedTheme)
            Fluent:SetTheme(selectedTheme)
            print("Theme has been switched to;", selectedTheme)
        end
    })

    local UserInputService = game:GetService("UserInputService")
    local currentBind = Enum.KeyCode.K
    local windowVisible = true -- Track window visibility

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == currentBind then
            Window:Minimize()
            windowVisible = not windowVisible -- Toggle visibility state
            if windowVisible then
                Fluent:Notify({
                    Title = "Window Opened",
                    Content = "Hub For The Strongest window has been opened.",
                    Duration = 4
                })
            else
                Fluent:Notify({
                    Title = "Window Minimized",
                    Content = "Hub For The Strongest window has been minimized.",
                    Duration = 4
                })
            end
        end
    end)

    -- Add manual key chooser (optional)
    Tabs.Settings:AddDropdown("MinimizeBindDropdown", {
        Title = "Set Minimize Key",
        Description = "Choose a key for minimizing the script, Leftcontrol will always be enabled. (Does not support your own keybinds because of how FluentPlus is coded.)",
        Values = {"K", "M", "P", "Return"},
        Default = "RightShift",
        Callback = function(selectedKey)
            currentBind = Enum.KeyCode[selectedKey]
            print("New minimize key set to:", selectedKey)
        end
    })


    Fluent:Notify({
        Title = "You Got A Notification!",
        Content = "Hub For The Strongest has been loaded!",
        Duration = 7
    })


else
    Fluent:Notify({
        Title = "Sorry! You are not in the correct game.",
        Content = "Hub For The Strongest (Kingly Hub) has not been loaded..",
        Duration = 7
    })
end
