

--[[
InventoryItem:
    id: string
    name: string
    quantity: number (optional)
]]

local InventoryTypes = {}

-- Example constructor for inventory items
function InventoryTypes.newItem(id, name, quantity)
    return {
        id = id,
        name = name,
        quantity = quantity or 1,
    }
end

return InventoryTypes
