local MatterUi = {}
MatterUi.Elements = {
    Tabs = {},
    Buttons = {}
}

-- Create a new window
function MatterUi:MakeWindow(windowConfig)
    local windowName = windowConfig.Name or "Matter Ui"
    local closeCallback = windowConfig.CloseCallback

    -- Create GUI Components
    local MatterUi = Instance.new("ScreenGui")
    local Window = Instance.new("Frame")
    local Panel = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
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
    Title.Size = UDim2.new(0.8, 0, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = windowName
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextScaled = true

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Panel
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0.2, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 0, 0)
    CloseButton.TextScaled = true

    LeftPanel.Name = "LeftPanel"
    LeftPanel.Parent = Window
    LeftPanel.BackgroundColor3 = Color3.new(0.32549, 0.101961, 1)
    LeftPanel.Size = UDim2.new(0.3, 0, 1, -45)
    LeftPanel.Position = UDim2.new(0, 0, 0, 45)

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = Window
    TabFrame.BackgroundColor3 = Color3.new(0.4, 0.164706, 1)
    TabFrame.Size = UDim2.new(0.7, 0, 1, -45)
    TabFrame.Position = UDim2.new(0.3, 0, 0, 45)

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

-- Create a new tab
function MatterUi:MakeTab(tabConfig)
    local tabName = tabConfig.Name or "New Tab"

    -- Create a new Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName
    TabButton.Parent = self.LeftPanel
    TabButton.BackgroundColor3 = Color3.new(1, 1, 1)
    TabButton.BackgroundTransparency = 0.3
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Position = UDim2.new(0, 0, #self.Elements.Tabs * 0.1, 0)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.new(0, 0, 0)
    TabButton.TextScaled = true

    -- Create a corresponding Tab Content Frame
    local TabContentFrame = Instance.new("Frame")
    TabContentFrame.Name = tabName .. "Content"
    TabContentFrame.Parent = self.TabFrame
    TabContentFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    TabContentFrame.Size = UDim2.new(1, 0, 1, 0)
    TabContentFrame.Visible = false -- Initially hidden

    -- Toggle Visibility of Tab Content
    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(self.TabFrame:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = false
            end
        end
        TabContentFrame.Visible = true
    end)

    -- Store tab in the Elements table
    table.insert(self.Elements.Tabs, TabButton)

    return {
        AddButton = function(self, buttonConfig)
            local buttonName = buttonConfig.Name or "New Button"
            local callback = buttonConfig.Callback or function() end

            -- Create a Button in the Tab Content Frame
            local Button = Instance.new("TextButton")
            Button.Name = buttonName
            Button.Parent = TabContentFrame
            Button.BackgroundColor3 = Color3.new(1, 1, 1)
            Button.BackgroundTransparency = 0.3
            Button.Size = UDim2.new(0.5, 0, 0, 40)
            Button.Position = UDim2.new(0, 10, (#TabContentFrame:GetChildren() - 1) * 0.1, 0)
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = buttonName
            Button.TextColor3 = Color3.new(0, 0, 0)
            Button.TextScaled = true

            -- Connect the Button's Click Event
            Button.MouseButton1Click:Connect(callback)

            -- Store button in the Elements table
            table.insert(MatterUi.Elements.Buttons, Button)
        end
    }
end

-- Destroy the UI
function MatterUi:Destroy()
    if self.Window and self.Window.Parent then
        self.Window.Parent:Destroy()
    end
end

return MatterUi
