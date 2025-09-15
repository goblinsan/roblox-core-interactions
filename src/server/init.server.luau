

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))

-- Register services explicitly from the Services folder (keeps load order explicit)
local servicesFolder = script.Parent:FindFirstChild("Services") or script.Parent
-- Use AddServicesDeep to pick up any ModuleScripts nested inside service folders.
-- This is robust to folder layout while keeping service load before Knit.Start().
Knit.AddServicesDeep(servicesFolder)

Knit.Start():andThen(function()
	local inventoryService = Knit.GetService("InventoryService")
end)