-- InventoryController
-- Minimal Knit Controller for inventory UI/interactions

-- Initialization
local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("knit"))

local InventoryController = Knit.CreateController { Name = "InventoryController" }

function InventoryController:GetInventory()
    return Knit.GetService("InventoryService").GetInventory()
end

function InventoryController:AddItem(item)
    return Knit.GetService("InventoryService").AddItem(item)
end

function InventoryController:RemoveItem(item)
    return Knit.GetService("InventoryService").RemoveItem(item)
end

return InventoryController
