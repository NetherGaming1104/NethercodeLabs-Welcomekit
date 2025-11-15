local ESX = nil
local QBCore = nil

-- ESX Laden
if Config.Framework == "es_extended" then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "qbcore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Debug
local function Debug(msg)
    if Config.Debug then
        print("^3[WelcomeKit-DEBUG]^0 " .. tostring(msg))
    end
end

-- Cache
local usedCache = {}

-- DATABASE – Check
CreateThread(function()
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS welcomekit_used (
            identifier VARCHAR(60) PRIMARY KEY,
            date_used TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]])
end)

local function getIdentifier(src)
    if Config.Framework == "es_extended" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.identifier
    else
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.citizenid
    end
end

local function getUsageDate(identifier)
    if usedCache[identifier] ~= nil then
        return usedCache[identifier]
    end

    local result = MySQL.scalar.await(
        "SELECT date_used FROM welcomekit_used WHERE identifier = ?",
        {identifier}
    )

    usedCache[identifier] = result or false
    return result
end

local function markUsed(identifier)
    MySQL.insert.await(
        "INSERT IGNORE INTO welcomekit_used (identifier, date_used) VALUES (?, NOW())",
        {identifier}
    )
    usedCache[identifier] = os.date("%Y-%m-%d %H:%M:%S")
end

-- === ITEM / MONEY VERGABE ===

local function giveItem(src, item, amount)
    if Config.InventorySystem == "ox_inventory" then
        exports.ox_inventory:AddItem(src, item, amount)
    elseif Config.Framework == "es_extended" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addInventoryItem(item, amount)
    elseif Config.Framework == "qbcore" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, amount)
    end
end

local function giveMoney(src)
    if Config.Framework == "es_extended" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if Config.Reward.money.cash > 0 then xPlayer.addMoney(Config.Reward.money.cash) end
        if Config.Reward.money.bank > 0 then xPlayer.addAccountMoney("bank", Config.Reward.money.bank) end

    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Reward.money.cash > 0 then Player.Functions.AddMoney("cash", Config.Reward.money.cash) end
        if Config.Reward.money.bank > 0 then Player.Functions.AddMoney("bank", Config.Reward.money.bank) end
    end
end

-- === MAIN LOGIC ===

local function grantKit(source)
    Debug("Starte grantKit für " .. source)

    local identifier = getIdentifier(source)
    if not identifier then
        Debug("Player Identifier NIL!")
        return
    end

    local used = getUsageDate(identifier)
    if used then
        TriggerClientEvent("NetherCodeLabs:WelcomeKitUsed", source, used)
        return
    end

    -- Geld
    if Config.Reward.money.enabled then
        giveMoney(source)
    end

    -- Items
    if Config.Reward.items.enabled then
        for _, v in ipairs(Config.Reward.items.list) do
            giveItem(source, v.name, v.count)
        end
    end

    -- Waffen
    if Config.Reward.weapons.enabled then
        for _, w in ipairs(Config.Reward.weapons.list) do
            giveItem(source, w.name, 1)
        end
    end

    markUsed(identifier)

    TriggerClientEvent("esx:showNotification", source, "🎉 Du hast dein Willkommens-Kit erhalten!")
end

-- === COMMAND ===
RegisterCommand(Config.CommandName, function(source)
    grantKit(source)
end)
