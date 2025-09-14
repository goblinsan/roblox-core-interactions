

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))

print("[Knit] Services to be added:")
for _, child in ipairs(script.Parent:GetChildren()) do
	print("[Knit] -", child.Name, child.ClassName)
end

Knit.AddServicesDeep(script.Parent)
-- Knit.AddServices(script.Parent:WaitForChild("Services"))

Knit.Start():andThen(function()
	print("Knit started!")
	local inventoryService = Knit.GetService("InventoryService")
	print("[Knit] InventoryService loaded:", inventoryService)
end)