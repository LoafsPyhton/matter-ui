local MatterUi = {}
MatterUi.Elements = {
    Tabs = {},
    Buttons = {},
    Sliders = {}
}

-- Function to generate a random icon for the Close Button
local function getRandomIcon()
    local iconIds = {
        "rbxassetid://12345678", -- Replace these with actual asset IDs
        "rbxassetid://23456789",
        "rbxassetid://34567890"
    }
    return iconIds[math.random(1, #iconIds)]
end

-- Create a new window
function MatterUi:MakeWindow(windowConfig)
    local windowName = windowConfig.Name or "Matter Ui"
    local closeCallback = windowConfig.CloseCallback

    -- Create GUI Components
    local MatterUi = Instance.new("ScreenGui")
    local Window = Instance.new("Frame")
    local Panel = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TitleIcon = Instance.new("ImageLabel")
    local CloseButton = Instance.new("TextButton")
    local LeftPanel = Instance.new("Frame")
    local TabFrame = Instance.new("Frame")

    -- Properties
    MatterUi.Name = "Matter Ui"
    MatterUi.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MatterUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Window.Name = "Window"
    Window.Parent = MatterUi
    Window.BackgroundColor3 = Color3.new(0.4, 0.164706, 1)
    Window.Position = UDim2.new(0.315, 0, 0.147, 0)
    Window.Size = UDim2.new(0, 500, 0, 441)

    Panel.Name = "Panel"
    Panel.Parent = Window
    Panel.BackgroundColor3 = Color3.new(0.32549, 0.101961, 1)
    Panel.Size = UDim2.new(1, 0, 0, 45)

    Title.Name = "Title"
    Title.Parent = Panel
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.1, 25, 0, 0) -- Offset for icon
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = windowName
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextScaled = true

    TitleIcon.Name = "TitleIcon"
    TitleIcon.Parent = Panel
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Position = UDim2.new(0, 5, 0.2, 0)
    TitleIcon.Size = UDim2.new(0, 35, 0, 35)
    TitleIcon.Image = "rbxassetid://0" -- Replace with your desired image ID

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Panel
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0.15, 0, 1, 0) -- Reduced size for better fit
    CloseButton.Position = UDim2.new(0.85, -10, 0, 0) -- Slightly moved left
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = ""
    CloseButton.TextColor3 = Color3.new(1, 0, 0)
    CloseButton.TextScaled = true

    local CloseButtonIcon = Instance.new("ImageLabel")
    CloseButtonIcon.Name = "CloseButtonIcon"
    CloseButtonIcon.Parent = CloseButton
    CloseButtonIcon.BackgroundTransparency = 1
    CloseButtonIcon.Size = UDim2.new(1, 0, 1, 0)
    CloseButtonIcon.Image = getRandomIcon() -- Get a random icon

    LeftPanel.Name = "LeftPanel"
    LeftPanel.Parent = Window
    LeftPanel.BackgroundColor3 = Color3.new(0.32549, 0.101961, 1)
    LeftPanel.Size = UDim2.new(0.3, 0, 1, -45)
    LeftPanel.Position = UDim2.new(0, 0, 0, 45)

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = Window
    TabFrame.BackgroundColor3 = Color3.fromRGB(102, 42, 255)
    TabFrame.Size = UDim2.new(0.7, 0, 1, -45)
    TabFrame.Position = UDim2.new(0.3, 0, 0, 45)

    -- Make Panel Draggable
    local dragging = false
    local dragStart, startPos

    Panel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
        end
    end)

    Panel.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    Panel.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Close Button Functionality
    CloseButton.MouseButton1Click:Connect(function()
        MatterUi:Destroy()
        if closeCallback then
            closeCallback()
        end
    end)

    -- Store references for later use
    self.Window = Window
    self.LeftPanel = LeftPanel
    self.TabFrame = TabFrame

    return self
end

-- Create a slider
function MatterUi:AddSlider(sliderConfig)
    local sliderName = sliderConfig.Name or "Slider"
    local min = sliderConfig.Min or 0
    local max = sliderConfig.Max or 100
    local default = sliderConfig.Default or min
    local increment = sliderConfig.Increment or 1
    local callback = sliderConfig.Callback or function() end

    -- Create Slider Components
    local SliderFrame = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    local Amount = Instance.new("TextLabel")

    -- SliderFrame properties
    SliderFrame.Name = sliderName
    SliderFrame.Parent = self.TabFrame
    SliderFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderFrame.BackgroundTransparency = 0.2
    SliderFrame.Size = UDim2.new(0.8, 0, 0, 30)
    SliderFrame.Position = UDim2.new(0.1, 0, (#self.Elements.Sliders * 0.12), 0)

    -- SliderButton properties
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderFrame
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Size = UDim2.new(0.1, 0, 1, 0)

    -- Amount Label properties
    Amount.Name = "Amount"
    Amount.Parent = SliderFrame
    Amount.Text = sliderName .. ": " .. tostring(default)
    Amount.Font = Enum.Font.SourceSansBold
    Amount.TextScaled = true
    Amount.TextColor3 = Color3.new(0, 0, 0)
    Amount.Size = UDim2.new(0.8, 0, 1, 0)
    Amount.Position = UDim2.new(0.15, 0, 0, 0)

    -- Update slider logic
    local dragging = false
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local sliderSize = SliderFrame.AbsoluteSize.X
            local sliderPos = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / sliderSize, 0, 1)
            local sliderValue = math.floor(min + sliderPos * (max - min) + 0.5)
            sliderValue = math.clamp(sliderValue, min, max)

            SliderButton.Position = UDim2.new(sliderPos, 0, 0, 0)
            Amount.Text = sliderName .. ": " .. sliderValue

            callback(sliderValue)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Store slider reference
    table.insert(self.Elements.Sliders, SliderFrame)
end

return MatterUi
