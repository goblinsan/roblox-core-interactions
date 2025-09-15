local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))
local Logger = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Logger"))

-- Register controllers explicitly from Controllers folder (clear structure for growth)
local controllersFolder = script.Parent:FindFirstChild("Controllers") or script.Parent
-- Require controllers recursively so nested layouts don't miss modules
Knit.AddControllersDeep(controllersFolder)

Knit.Start():andThen(function()
	-- Locate the UI folder. Some Rojo mappings place `src/client` under a nested `Client` folder
	-- inside PlayerScripts (e.g. PlayerScripts.Client.UI). Try both locations and fail fast.
	local uiFolder = script.Parent:FindFirstChild("UI")
	if not uiFolder then
		local clientFolder = script.Parent:FindFirstChild("Client")
		if clientFolder then
			uiFolder = clientFolder:FindFirstChild("UI")
		end
	end

	if not uiFolder then
		error("InventoryUI folder not found under PlayerScripts. Ensure `src/client/UI` is mapped into StarterPlayerScripts correctly.")
	end

	local inventoryModule = uiFolder:FindFirstChild("InventoryUI")
	if not inventoryModule then
		error("InventoryUI ModuleScript not found in UI folder")
	end

	local InventoryUI = require(inventoryModule)

	if type(InventoryUI.init) == "function" then
		InventoryUI.init()
	else
		Logger.warn("InventoryUI module loaded but has no init() function")
	end
end)