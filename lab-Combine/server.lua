local ox_inventory = exports.ox_inventory

---@type table<string, { amount: table<string, number>, otherItem: string, duration: number, result: string }>
local Combinations = { --create new item craft Recipies here. limited to 2 items per craft, but you can have multiple of each of those 2 items if desired

    ['coca'] = { --item1
	otherItem = 'baggy', --item2
        amount = {['baggy'] = 1, ['coca'] = 1}, --amount of each item needed to craft. must match item1 and item2
        duration = 2000, --how long the craft takes
        result = 'coke' -- the item you get after craft
    },
	
    ['meth'] = { --item1
	otherItem = 'baggy', --item2
        amount = {['baggy'] = 1, ['meth'] = 1}, --amount of each item needed to craft. must match item1 and item2
        duration = 2000, --how long the craft takes
        result = 'packagedmeth' -- the item you get after craft
    },
    
}

local craftHook = ox_inventory:registerHook('swapItems', function(data)
    if type(data.fromSlot) == "table" and type(data.toSlot) == "table" then

        if data.fromSlot?.name == data.toSlot?.name then return end

        local item1 = (Combinations[data.fromSlot?.name] and data?.fromSlot) or (Combinations[data.toSlot?.name] and data.toSlot)
        if not item1 then return end

        if Combinations[item1.name].amount[item1.name] > item1.count then
            TriggerClientEvent('ox_lib:notify', data.source,
            {
                type = 'error',
                description = ("Not enough %s. Need %.0f"):format(item1.label, Combinations[item1.name].amount[item1.name])
            })
            return false
        end

        local item2 = (Combinations[item1.name].otherItem == data.fromSlot.name and data.fromSlot) or (Combinations[item1.name].otherItem == data.toSlot.name and data.toSlot)
        if not item2 then return end

        if Combinations[item1.name].amount[item2.name] > item2.count then
            TriggerClientEvent('ox_lib:notify', data.source,
            {
                type = 'error',
                description = ("Not enough %s. Need %.0f"):format(item2.label, Combinations[item1.name].amount[item2.name])
            })
            return false
        end

        TriggerClientEvent('ox_inventory:closeInventory', data.source)
        TriggerClientEvent('lab-Combine:Combine', data.source, Combinations[item1.name].duration)

        CraftQueue[data.source] = {item1 = item1.name, item2 = item2.name, result = Combinations[item1.name].result}

        return false
    end
end, {})


lib.callback.register('lab-Combine:success', function(source, success)
    local data = CraftQueue[source]

    if not data then return end

    if success then
        ox_inventory:RemoveItem(source, data.item1, 1)
        ox_inventory:RemoveItem(source, data.item2, 1)
        ox_inventory:AddItem(source, data.result, 1)
    end

    CraftQueue[source] = nil
end)
