

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))

-- Add services and start Knit
Knit.AddServicesDeep(script.Parent)
-- Knit.AddServices(script.Parent:WaitForChild("Services"))

Knit.Start():andThen(function()
	local inventoryService = Knit.GetService("InventoryService")
end)