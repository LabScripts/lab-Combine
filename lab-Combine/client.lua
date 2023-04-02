RegisterNetEvent('lab-Combine:Combine', function(duration)
    local result = lib.progressCircle({
        duration = duration,
        label = 'Crafting..',
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'amb@prop_human_parking_meter@male@base',
            clip = 'base'
        },
    })

    lib.callback('srp-dragCraft:success', false, function() end, result)
end)
