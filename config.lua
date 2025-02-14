Config = {}

Config.defaultlang = "de_lang"
Config.LatestVORPInvetory = true -- Make you to Check your Version if you Are Up to Date Else set it to false

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