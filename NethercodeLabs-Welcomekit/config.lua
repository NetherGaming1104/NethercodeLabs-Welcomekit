Config = {}

-- ============================================================
-- FRAMEWORK
-- ============================================================
-- Wähle das Framework deines Servers:
-- 'es_extended' oder 'qbcore'
Config.Framework = 'es_extended'

-- ============================================================
-- DEBUG
-- ============================================================
-- true = Debug-Ausgaben aktiv (Server & Client)
Config.Debug = true

-- ============================================================
-- INVENTORY SYSTEM
-- ============================================================
-- Für ESX:     'esx_standard', 'ox_inventory'
-- Für QBCore:  'qb_inventory', 'ox_inventory'
Config.InventorySystem = 'esx_standard'

-- ============================================================
-- COMMAND
-- ============================================================
-- Befehl, mit dem Spieler das Willkommens-Kit abrufen
Config.CommandName = 'welcome'

-- ============================================================
-- NOTIFY SYSTEM
-- ============================================================
-- 'auto' = erkennt ESX/QBCore automatisch
-- 'esx'  = erzwingt ESX Notify
-- 'qb'   = erzwingt QBCore Notify
-- 'native' = GTA Fallback
Config.Notify = "auto"

-- ============================================================
-- REWARDS
-- ============================================================
Config.Reward = {

    -- =====================================================
    -- GELD
    -- =====================================================
    money = {
        enabled = false,     -- true = Geld aktiv
        cash = 5000,         -- Bargeld
        bank = 10000         -- Bank
    },

    -- =====================================================
    -- ITEMS
    -- =====================================================
    items = {
        enabled = true,      -- true = Items aktiv
        list = {
            { name = 'hotdog', count = 5 },
            { name = 'cola',   count = 5 },
            { name = 'phone',  count = 1 }
        }
    },

    -- =====================================================
    -- WAFFEN
    -- =====================================================
    weapons = {
        enabled = false,     -- true = Waffen aktiv
        list = {
            { name = 'weapon_pistol', ammo = 50 }
        }
    }
}
