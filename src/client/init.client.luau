local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("knit"))
local Logger = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Logger"))

Knit.AddControllersDeep(script.Parent)

Knit.Start():andThen(function()
	local ok, InventoryUI = pcall(function()
		return require(script.Parent.InventoryUI)
	end)

	-- If direct sibling require failed, try a recursive search under script.Parent
	if (not ok or not InventoryUI) then
		local function findChildRecursive(parent, name)
			for _, child in ipairs(parent:GetChildren()) do
				if child.Name == name then
					return child
				end
				local found = findChildRecursive(child, name)
				if found then return found end
			end
			return nil
		end

		local found = findChildRecursive(script.Parent, "InventoryUI")
		if found then
			local ok2, mod2 = pcall(function() return require(found) end)
			if ok2 and mod2 then
				ok = ok2
				InventoryUI = mod2
			end
		end

		if (not ok or not InventoryUI) then
			Logger.warn("Could not require InventoryUI module. Ensure InventoryUI ModuleScript is a sibling of init.client or placed in ReplicatedStorage.Shared")
			return
		end

		end

		if type(InventoryUI.init) == "function" then
		InventoryUI.init()
	else
		Logger.warn("InventoryUI module loaded but has no init() function")
	end
end)