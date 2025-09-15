local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))
local Logger = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Logger"))

-- Register controllers explicitly from Controllers folder (clear structure for growth)
local controllersFolder = script.Parent:FindFirstChild("Controllers") or script.Parent
-- Require controllers recursively so nested layouts don't miss modules
Knit.AddControllersDeep(controllersFolder)

Knit.Start():andThen(function()
	-- Debug: print PlayerScripts children so we can diagnose why WaitForChild("UI") would yield.
	Logger.debug("PlayerScripts children:")
	for _, child in ipairs(script.Parent.Parent:GetChildren()) do
		Logger.debug(" -", child.Name)
	end

	-- Also log the Client folder contents (where UI is expected)
	Logger.debug("Client folder (script.Parent) name:", script.Parent.Name)
	Logger.debug("Client children:")
	for _, child in ipairs(script.Parent:GetChildren()) do
		Logger.debug(" -", child.Name)
	end

	-- Extra: log more info about the 'Client' object Robox Studio has created
	local clientObj = script.Parent.Parent:FindFirstChild("Client")
	if clientObj then
		Logger.debug("Found top-level 'Client' object under PlayerScripts. ClassName:", clientObj.ClassName)
		Logger.debug("Top-level 'Client' children:")
		for _, c2 in ipairs(clientObj:GetChildren()) do
			Logger.debug(" --", c2.Name, "(", c2.ClassName, ")")
		end
	else
		Logger.debug("No top-level 'Client' object found under PlayerScripts")
	end

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