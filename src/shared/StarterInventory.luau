-- StarterInventory
-- Temporary module for testing inventory seeding

local StarterInventory = {
    { id = "coins", name = "Coins", quantity = 100 },
    { id = "fishing_rod", name = "Fishing Rod", rarity = "Common", equipable = true, durability = { current = 50, max = 50 } },
    { id = "bait_worms", name = "Bait: Worms", quantity = 20, consumable = true, stackable = true },
    { id = "torch", name = "Torch", equipable = true, fuel = 60 },
    { id = "bandage", name = "Bandage", quantity = 3, consumable = true, effect = "heal" },
    { id = "water_flask", name = "Water Flask", fill = 2, capacity = 3, refillable = true },
    { id = "basic_axe", name = "Basic Axe", tool = "wood" },
    { id = "rope", name = "Rope", quantity = 5, crafting = true },
}

return StarterInventory
