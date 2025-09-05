return {
    ---@type number Durability percentage lost per uses
    durabilityPerUse = 1,

    ---@type string Item required to use gold panning
    panningItem = 'goldpan',

    ---@type { common: number, uncommon: number, rare: number } Rarity weights for random selection
    rarityWeights = {
        common = 70,
        uncommon = 25,
        rare = 5
    },

    ---@type { min: number, max: number } Number of items given per successful panning
    itemsPerPanning = { min = 3, max = 5 },

    ---@type { item: string, rarity: string, min: number, max: number }[] Reward items and difficulty
    rewards = {
        {
            item = "rock",
            rarity = 'common',
            min = 1,
            max = 5
        },
        {
            item = "steel",
            rarity = 'common',
            min = 1,
            max = 5
        },
        {
            item = "copper",
            rarity = 'common',
            min = 1,
            max = 5
        },
        {
            item = "aluminum",
            rarity = 'common',
            min = 1,
            max = 5
        },
        {
            item = "crystal",
            rarity = 'uncommon',
            min = 1,
            max = 5
        },
        {
            item = "quartz",
            rarity = 'uncommon',
            min = 1,
            max = 3
        },
        {
            item = "silver",
            rarity = 'uncommon',
            min = 1,
            max = 3
        },
        {
            item = "gold",
            rarity = 'rare',
            min = 1,
            max = 4
        }
    }
}