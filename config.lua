Config = {}

Config.defaultlang = "de_lang"


------------------------ Goldpanning Settings -----------------

Config.GoldPanItem = 'goldpan'   --- Goldpan item DB name
Config.GoldPanTime = 25000  ------ Time for Searching
Config.RewardChance = 75  ----- 75% Success Rate
Config.ToolUsage = 2   ----- Remove Tool Usage Per Goldsearch

-- Return an item when the player's gold pan reaches 0 durability? 
Config.ReturnItemOnDepletion = "goldpan_broken" -- false or item name like "goldpan_broken"
--[[
You can run this query to add an basic broken gold pan to your server's database:
INSERT IGNORE INTO items (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) 
VALUES ('goldpan_broken', 'Gold pan (broken)', 10, 1, 'item_standard', 0, 'A broken gold pan. Perhaps a blacksmith can repair it or at least melt it down.');
--]]


------------------------ SkillCheck Settings ------------------

-- uses syn_minigame, which usually comes bundled with VORP
Config.DoSkillCheck  = true -- Shall user have to absolve a minigame for skillcheck?
Config.MaxDifficulty = 3000  -- Lower number is harder.
Config.MinDifficulty = 6000  -- Lower number is harder.


----------------------- Reward Settings -----------------------

-- Max Chance is 100% if Normal is 70 Rare Chance is 30

Config.NormalChance = 90

Config.NormalItems = {   ---- As Higher the Chance to find an item
    { Name = "rock", Label = "Stein", Amount = 1 },
    { Name = "rock", Label = "Stein", Amount = 2 },
    { Name = "gold_nugget", Label = "Gold Nugget", Amount = 1 },
    { Name = "gold_nugget", Label = "Gold Nugget", Amount = 2 },
    { Name = "gold_nugget", Label = "Gold Nugget", Amount = 3 },

}

Config.RareItems = {   ---- As Higher the Chance to find an item
    { Name = "goldring", Label = "Goldring", Amount = 1 },
    { Name = "diamond", Label = "Diamant", Amount = 1 },
    { Name = "emerald", Label = "Smaragd", Amount = 1 },
    { Name = "gold_nugget", Label = "Gold Nugget", Amount = 4 },
    { Name = "gold_nugget", Label = "Gold Nugget", Amount = 5 },
}


----------------------------------------------------------------
Config.locations = { -- Wild Water Locations
    [1]  = { name = 'Sea of Coronado',     hash = -247856387  },
    [2]  = { name = 'San Luis River',      hash = -1504425495 },
    [3]  = { name = 'Lake Don Julio',      hash = -1369817450 },
    [4]  = { name = 'Flat Iron Lake',      hash = -1356490953 },
    [5]  = { name = 'Upper Montana River', hash = -1781130443 },
    [6]  = { name = 'Owanjila',            hash = -1300497193 },
    [7]  = { name = 'Hawks Eye Creek',     hash = -1276586360 },
    [8]  = { name = 'Little Creek River',  hash = -1410384421 },
    [9]  = { name = 'Dakota River',        hash =  370072007  },
    [10] = { name = 'Beartooth Beck',      hash =  650214731  },
    [11] = { name = 'Lake Isabella',       hash =  592454541  },
    [12] = { name = 'Cattail Pond',        hash = -804804953  },
    [13] = { name = 'Deadboot Creek',      hash =  1245451421 },
    [14] = { name = 'Spider Gorge',        hash = -218679770  },
    [15] = { name = 'O\'Creagh\'s Run',    hash = -1817904483 },
    [16] = { name = 'Moonstone Pond',      hash = -811730579  },
    [17] = { name = 'Kamassa River',       hash = -1229593481 },
    [18] = { name = 'Elysian Pool',        hash = -105598602  },
    [19] = { name = 'Heartlands Overflow', hash =  1755369577 },
    [20] = { name = 'Lagras Bayou',        hash = -557290573  },
    [21] = { name = 'Lannahechee River',   hash = -2040708515 },
    [22] = { name = 'Calmut Ravine',       hash =  231313522  },
    [23] = { name = 'Ringneck Creek',      hash =  2005774838 },
    [24] = { name = 'Stillwater Creek',    hash = -1287619521 },
    [25] = { name = 'Lower Montana River', hash = -1308233316 },
    [27] = { name = 'Aurora Basin',        hash = -196675805  },
    [28] = { name = 'Barrow Lagoon',       hash =  795414694  },
    [29] = { name = 'Arroyo De La Vibora', hash = -49694339   },
    [30] = { name = 'Bahia De La Paz',     hash = -1168459546 },
    [31] = { name = 'Dewberry Creek',      hash =  469159176  },
    [32] = { name = 'Whinyard Strait',     hash = -261541730  },
    [33] = { name = 'Cairn Lake',          hash = -1073312073 },
    [34] = { name = 'Hot Springs',         hash =  1175365009 },
    [35] = { name = 'Mattlock Pond',       hash =  301094150  },
    [36] = { name = 'Southfield Flats',    hash = -823661292  },
}
