-- InventoryUI
-- Minimal inventory UI system with list and buttons

local InventoryUI = {}

-- runtime diagnostics removed

function InventoryUI.init()
    local Players = game:GetService("Players")
    local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("knit"))
    local InventoryController = Knit.GetController("InventoryController")

    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    local function createInventoryGui()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "InventoryUI"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = PlayerGui
        screenGui.Enabled = false

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 400)
        frame.Position = UDim2.new(0, 20, 0, 100)
        frame.BackgroundTransparency = 0.2
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.Parent = screenGui

        local title = Instance.new("TextLabel")
        title.Text = "Inventory"
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundTransparency = 1
        title.TextColor3 = Color3.new(1, 1, 1)
        title.Font = Enum.Font.SourceSansBold
        title.TextSize = 28
        title.Parent = frame

        local list = Instance.new("ScrollingFrame")
        list.Size = UDim2.new(1, -20, 1, -60)
        list.Position = UDim2.new(0, 10, 0, 50)
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        list.BackgroundTransparency = 1
        list.ScrollBarThickness = 8
        list.Parent = frame

        local layout = Instance.new("UIListLayout")
        layout.Parent = list
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        return screenGui, list
    end

    local function refreshInventory(list, items)
        list:ClearAllChildren()
        for i, item in ipairs(items) do
            local itemFrame = Instance.new("Frame")
            itemFrame.Size = UDim2.new(1, 0, 0, 40)
            itemFrame.BackgroundTransparency = 0.4
            itemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            itemFrame.Parent = list

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Text = item.name .. (item.quantity and (" x" .. tostring(item.quantity)) or "")
            nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.Font = Enum.Font.SourceSans
            nameLabel.TextSize = 20
            nameLabel.Parent = itemFrame

            local addBtn = Instance.new("TextButton")
            addBtn.Text = "+"
            addBtn.Size = UDim2.new(0.2, -5, 1, -10)
            addBtn.Position = UDim2.new(0.6, 5, 0, 5)
            addBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
            addBtn.TextColor3 = Color3.new(1, 1, 1)
            addBtn.Font = Enum.Font.SourceSansBold
            addBtn.TextSize = 20
            addBtn.Parent = itemFrame
            addBtn.MouseButton1Click:Connect(function()
                InventoryController:AddItem(item)
            end)

            local removeBtn = Instance.new("TextButton")
            removeBtn.Text = "-"
            removeBtn.Size = UDim2.new(0.2, -5, 1, -10)
            removeBtn.Position = UDim2.new(0.8, 5, 0, 5)
            removeBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
            removeBtn.TextColor3 = Color3.new(1, 1, 1)
            removeBtn.Font = Enum.Font.SourceSansBold
            removeBtn.TextSize = 20
            removeBtn.Parent = itemFrame
            removeBtn.MouseButton1Click:Connect(function()
                InventoryController:RemoveItem(item)
            end)
        end
        list.CanvasSize = UDim2.new(0, 0, 0, #items * 45)
    end

    local screenGui, list = createInventoryGui()

    local function openInventory()
        screenGui.Enabled = true
        InventoryController:GetInventory():andThen(function(items)
            refreshInventory(list, items)
        end)
    end

    local function closeInventory()
        screenGui.Enabled = false
    end

    local ContextActionService = game:GetService("ContextActionService")
    local function toggleInventoryAction(actionName, inputState, inputObj)
        if inputState == Enum.UserInputState.Begin then
            if screenGui.Enabled then
                closeInventory()
            else
                openInventory()
            end
        end
    end
    ContextActionService:BindAction("ToggleInventoryUI", toggleInventoryAction, false, Enum.KeyCode.Y, Enum.KeyCode.ButtonY)
end

return InventoryUI
