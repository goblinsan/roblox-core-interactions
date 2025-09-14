-- InventoryController
-- Minimal Knit Controller for inventory UI/interactions
local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("knit"))
local Promise = require(Knit.Util.Promise)

local InventoryController = Knit.CreateController { Name = "InventoryController" }

function InventoryController:GetInventory()
    return Promise.new(function(resolve, reject)
        Knit.GetService("InventoryService").GetInventory():andThen(resolve):catch(reject)
    end)
end

function InventoryController:AddItem(item)
    return Promise.new(function(resolve, reject)
        Knit.GetService("InventoryService").AddItem(item):andThen(resolve):catch(reject)
    end)
end

function InventoryController:RemoveItem(item)
    return Promise.new(function(resolve, reject)
        Knit.GetService("InventoryService").RemoveItem(item):andThen(resolve):catch(reject)
    end)
end

return InventoryController
