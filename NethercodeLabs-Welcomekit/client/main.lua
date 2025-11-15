-- client/main.lua

-- Event-Listener für die Benachrichtigung, wenn das Kit bereits verwendet wurde
RegisterNetEvent('NetherCodeLabs:WelcomeKitUsed', function(dateUsed)
    
    -- Datum formatieren: yyyy-mm-dd (Tag) und HH:MM (Uhrzeit)
    local dateOnly = string.sub(dateUsed, 1, 10) 
    local timeOnly = string.sub(dateUsed, 12, 16) 

    local message = string.format('Du hast das Willkommens-Kit bereits am %s um %s Uhr erhalten.', dateOnly, timeOnly)
    
    -- Zeigt die Benachrichtigung, abhängig vom Framework
    if GetResourceState('es_extended') == 'started' then
        -- === NEU: NUTZT ESX_NOTIFY FÜR PROFESSIONELLE ANZEIGE ===
        if exports['esx_notify'] then
            exports['esx_notify']:addNotification({
                type = 'error',         -- Typ: error, success, info, warning
                message = message,
                duration = 7000,        -- Dauer in Millisekunden
                icon = 'fas fa-times-circle' -- Optional: Icon-Klasse
            })
        else
            -- Fallback, falls esx_notify nicht läuft
            exports['es_extended']:showNotification('❌ ' .. message, 7000)
        end
        
    elseif GetResourceState('qb-core') == 'started' then
        -- Für QBCore (nutzt das QBCore Notify System)
        exports['qb-core']:Notify(message, 'error', 7000)
        
    else
        -- Fallback-Benachrichtigung (wenn Framework nicht gefunden)
        SetNotificationTextEntry("STRING")
        AddTextComponentString("NETHERCODE: " .. message)
        DrawNotification(false, false)
    end
end)