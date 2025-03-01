Config = {}

Config.defaultlang = "de_lang"
Config.LatestVORPInvetory = true -- Make you to Check your Version if you Are Up to Date Else set it to false
Config.Debug = false
-- Webhook Settings

Config.WebHook = false

Config.WHTitle = 'Cactus:'
Config.WHLink = ''  -- Discord WH link Here
Config.WHColor = 16711680 -- red
Config.WHName = 'Cactus:' -- name
Config.WHLogo = '' -- must be 30x30px
Config.WHFooterLogo = '' -- must be 30x30px
Config.WHAvatar = '' -- must be 30x30px

-- Script Settings

Config.ResetCactusTimer = 1 -- Time in minute to Reset Cactus

Config.CactusProps = {
    { Prop = 'rdr2_bush_beavertailcactus_02' },
    { Prop = 'p_tree_cactus_01d' },
    { Prop = 'p_tree_cactus_01a' },
    { Prop = 'p_tree_cactus_01c' },
    { Prop = 'p_tree_cactus_01e' },
    { Prop = 'rdr2_bush_chollocactus' },
}

Config.ChopItem = 'hatchet' -- Make sure its not used in Another Script in case it get Buggy then 
Config.ChopItem2 = 'hatchet2' -- Make sure its not used in Another Script in case it get Buggy then
Config.ItemUsage = 1 -- Usage Per Swing
Config.ItemMaxUses = 250 -- Max Durability
Config.ItemMaxUses2 = 250 -- Max Durability
Config.ChopTime = 3500  -- Time in MS 5000 = 5 Sec
Config.ToolHash = 'p_axe02x' -- Axt Model

Config.AlwaysGetItem = true -- If You wanna Always get an Item
Config.AlwaysItem = 'cactusfruit' -- item to Get.
Config.AlwaysItemLabel = 'Kaktusfrucht' -- item Label
Config.AlwaysItemAmount = 4 -- Get 4 Every Swing no Empty Swings

-- Repair Sytem 

Config.RepairItem = 'rock' -- Item To Repair the Tool
Config.RepairItemUsage = 1 -- 1 Item Needed to Repair
Config.RepairAmount = 150 -- How Much Durability Should be added.
Config.RepairTime = 5 -- Time in Sec
Config.CanMoreThenMaxUses = true

-- Reward System

Config.LuckyItems = true
Config.LuckyChance = 6 -- 1 = 10% , 2 = 20% ....
Config.LuckyItemsTable = {
    { Item = 'wood', Label = 'Weichholz', Amount = 4 },
    { Item = 'hwood', Label = 'Hartholz', Amount = 4 },
    { Item = 'rock', Label = 'Stein', Amount = 4 },
}

Config.JobMultiplier = true

Config.JobBonus = {
    { Job = 'farmer', Multiplier = 2.0 },  -- 1 = 100% if you got on 0.5 then it makes less Reward for this Job so you can give more or Lower in case of job
    { Job = 'hunter', Multiplier = 1.5 },
    { Job = 'schmied', Multiplier = 2.5 },
}

--- Its always the Center of Town and The Distance is a Radius from the Middle so if its a small town like strawberry its like 50
--- A Bigger Town like Saint Denise needs 400 Meters. you need to test

Config.TownRestriction = true

Config.Towns = {
    { Town = vector3(-281.13, 715.79, 113.93),      TownDistance = 250,  TownName = 'Valentine' }, -- Valentine
    { Town = vector3(1341.21, -1277.12, 76.94),     TownDistance = 200,  TownName = 'Rhodes' }, -- Rhodes
    { Town = vector3(-1798.92, -457.03, 159.48),    TownDistance = 200,  TownName = 'Strawberry' }, -- Strawberry
    { Town = vector3(-850.22, -1298.28, 43.37),     TownDistance = 300,  TownName = 'Blackwater' }, -- Blackwater
    { Town = vector3(2919.48, 1368.80, 45.24),      TownDistance = 400,  TownName = 'Annesburg' }, -- Annesburg
    { Town = vector3(2962.95, 547.93, 44.50),       TownDistance = 210,  TownName = 'Van Horn' }, -- Van Horn
    { Town = vector3(2613.23, -1216.01, 53.39),     TownDistance = 700,  TownName = 'Saint Denise' }, -- Saint Denise
    { Town = vector3(-5506.68, -2941.55, -1.80),    TownDistance = 550,  TownName = 'Tumbleweed' }, -- Tumbleweed
    { Town = vector3(-3689.10, -2609.74, -14.03),   TownDistance = 350,  TownName = 'Armadillo' }, -- Armadillo
}
