-- InventoryService
-- Minimal Knit Service for inventory management

local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("knit"))
local Signal = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("signal"))
local StarterInventory = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("StarterInventory"))

local InventoryService = Knit.CreateService {
    Name = "InventoryService",
    Client = {}
}

InventoryService.ItemAdded = Signal.new()
InventoryService.ItemRemoved = Signal.new()

local playerInventories = {}

function InventoryService:GetInventory(player)
    return playerInventories[player] or {}
end

function InventoryService:SeedStarterInventory(player)
    playerInventories[player] = playerInventories[player] or {}
    for _, item in ipairs(StarterInventory) do
        table.insert(playerInventories[player], item)
        self.ItemAdded:Fire(player, item)
    end
end

function InventoryService:AddItem(player, item)
    playerInventories[player] = playerInventories[player] or {}
    table.insert(playerInventories[player], item)
    self.ItemAdded:Fire(player, item)
    return true
end

function InventoryService:RemoveItem(player, item)
    local inventory = playerInventories[player]
    if not inventory then return false end
    for i, v in ipairs(inventory) do
        if v == item then
            table.remove(inventory, i)
            self.ItemRemoved:Fire(player, item)
            return true
        end
    end
    return false
end

function InventoryService.Client:GetInventory(player)
    return self.Server:GetInventory(player)
end

function InventoryService.Client:AddItem(player, item)
    return self.Server:AddItem(player, item)
end

function InventoryService.Client:RemoveItem(player, item)
    return self.Server:RemoveItem(player, item)
end


-- Seed starter inventory for each tester on join
game:GetService("Players").PlayerAdded:Connect(function(player)
    InventoryService:SeedStarterInventory(player)
end)

return InventoryService
