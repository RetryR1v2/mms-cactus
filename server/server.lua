local VORPcore = exports.vorp_core:GetCore()

exports.vorp_inventory:registerUsableItem(Config.ChopItem, function(data)
    local src = data.source
    local ItemId = data.item.mainid
    local UsedItem = Config.ChopItem
    local MaxUses = Config.ItemMaxUses
    TriggerClientEvent('mms-cactus:client:ToolOut',src,ItemId,UsedItem,MaxUses)
end)

exports.vorp_inventory:registerUsableItem(Config.ChopItem2, function(data)
    local src = data.source
    local ItemId = data.item.mainid
    local UsedItem = Config.ChopItem2
    local MaxUses = Config.ItemMaxUses2
    TriggerClientEvent('mms-cactus:client:ToolOut',src,ItemId,UsedItem,MaxUses)
end)

RegisterServerEvent('mms-cactus:server:FinishChoppingcactus',function(ToolId,CurrentItem,CurrentItemMaxUses)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    local Multiplier = 1
    local job = Character.job
    for h,v in ipairs(Config.JobBonus) do
        if v.Job == job then
            Multiplier = v.Multiplier
        end
    end
    if Config.JobMultiplier then
        if Config.AlwaysGetItem then
            local CanCarryItem = exports.vorp_inventory:canCarryItem(src, Config.AlwaysItem, Config.AlwaysItemAmount  * Multiplier)
            if CanCarryItem then
                exports.vorp_inventory:addItem(src, Config.AlwaysItem, Config.AlwaysItemAmount * Multiplier)
                VORPcore.NotifyRightTip(src,_U('YouGot') .. Config.AlwaysItemAmount  * Multiplier .. ' ' .. Config.AlwaysItemLabel,5000)
                if Config.WebHook  then
                    VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHGot') .. Config.AlwaysItemAmount  * Multiplier .. ' ' .. Config.AlwaysItemLabel, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
                end
            else
                VORPcore.NotifyRightTip(src,_U('NoMoreInventorySpaceFor') .. Config.AlwaysItemAmount  * Multiplier .. ' ' .. Config.AlwaysItemLabel,5000)
            end
        end
        --- Lucky Bonus Item Part
        if Config.LuckyItems then
            local Chance = math.random(1,10)
            if Chance <= Config.LuckyChance then
                local MaxIndex = #Config.LuckyItemsTable
                local RandomIndex = math.random(1,MaxIndex)
                local PickedItem = Config.LuckyItemsTable[RandomIndex]
                local CanCarryItem = exports.vorp_inventory:canCarryItem(src, PickedItem.Item, PickedItem.Amount * Multiplier)
                if CanCarryItem then
                    exports.vorp_inventory:addItem(src, PickedItem.Item, PickedItem.Amount  * Multiplier)
                    VORPcore.NotifyRightTip(src,_U('YouGotLuck') .. PickedItem.Amount  * Multiplier .. ' ' .. PickedItem.Label,5000)
                if Config.WebHook  then
                    VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHGotLucky') .. PickedItem.Amount  * Multiplier .. ' ' .. PickedItem.Label, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
                end
                else
                    VORPcore.NotifyRightTip(src,_U('NoMoreInventorySpaceFor') .. PickedItem.Amount  * Multiplier .. ' ' .. PickedItem.Label,5000)
                end
            end
        end
    else
    --- Always Item Part so no Empty swing
    if Config.AlwaysGetItem then
        local CanCarryItem = exports.vorp_inventory:canCarryItem(src, Config.AlwaysItem, Config.AlwaysItemAmount)
        if CanCarryItem then
            exports.vorp_inventory:addItem(src, Config.AlwaysItem, Config.AlwaysItemAmount)
            VORPcore.NotifyRightTip(src,_U('YouGot') .. Config.AlwaysItemAmount .. ' ' .. Config.AlwaysItemLabel,5000)
            if Config.WebHook  then
                VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHGot') .. Config.AlwaysItemAmount .. ' ' .. Config.AlwaysItemLabel, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
        else
            VORPcore.NotifyRightTip(src,_U('NoMoreInventorySpaceFor') .. Config.AlwaysItemAmount .. ' ' .. Config.AlwaysItemLabel,5000)
        end
    end
    --- Lucky Bonus Item Part
    if Config.LuckyItems then
        local Chance = math.random(1,10)
        if Chance <= Config.LuckyChance then
            local MaxIndex = #Config.LuckyItemsTable
            local RandomIndex = math.random(1,MaxIndex)
            local PickedItem = Config.LuckyItemsTable[RandomIndex]
            local CanCarryItem = exports.vorp_inventory:canCarryItem(src, PickedItem.Item, PickedItem.Amount)
            if CanCarryItem then
                exports.vorp_inventory:addItem(src, PickedItem.Item, PickedItem.Amount)
                VORPcore.NotifyRightTip(src,_U('YouGotLuck') .. PickedItem.Amount .. ' ' .. PickedItem.Label,5000)
            if Config.WebHook  then
                VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHGotLucky') .. PickedItem.Amount .. ' ' .. PickedItem.Label, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
            else
                VORPcore.NotifyRightTip(src,_U('NoMoreInventorySpaceFor') .. PickedItem.Amount .. ' ' .. PickedItem.Label,5000)
            end
        end
    end
end
    --- Remove Tool / Tool Durability
    local ItemData = exports.vorp_inventory:getItemById(src, ToolId)
    if ItemData.metadata.cactusdurability ~= nil then
        local NewDurability = ItemData.metadata.cactusdurability - Config.ItemUsage
        if NewDurability < Config.ItemUsage then
            if not Config.LatestVORPInvetory then
                exports.vorp_inventory:subItemID(src, ToolId)
                TriggerClientEvent('mms-cactus:client:ToolOut',src,ToolId)
                VORPcore.NotifyRightTip(src,_U('ToolBroken'),5000)
            else
                exports.vorp_inventory:subItemById(src, ToolId,nil,nil,1)
                TriggerClientEvent('mms-cactus:client:ToolOut',src,ToolId)
                VORPcore.NotifyRightTip(src,_U('ToolBroken'),5000)
            end
        else
            exports.vorp_inventory:setItemMetadata(src, ToolId, { description = _U('Durability') .. NewDurability, cactusdurability =  NewDurability }, 1, nil)
            local NewItemID = exports.vorp_inventory:getItem(src, CurrentItem,nil, { description = _U('Durability') .. NewDurability, cactusdurability =  NewDurability })
            local NewToolId = NewItemID.id
            TriggerClientEvent('mms-cactus:client:UpdateItemId',src,NewToolId)
        end
    else
        local Durability = CurrentItemMaxUses - Config.ItemUsage
        exports.vorp_inventory:setItemMetadata(src, ToolId, { description = _U('Durability') .. Durability, cactusdurability =  Durability }, 1, nil)
        Citizen.Wait(150)
        local NewItemID = exports.vorp_inventory:getItem(src, CurrentItem,nil, { description = _U('Durability') .. Durability, cactusdurability =  Durability })
        local NewToolId = NewItemID.id
        TriggerClientEvent('mms-cactus:client:UpdateItemId',src,NewToolId)
    end
end)