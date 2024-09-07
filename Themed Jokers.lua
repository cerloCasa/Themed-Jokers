--- STEAMODDED HEADER
--- MOD_NAME: Themed Jokers
--- MOD_ID: ThemedJokers
--- MOD_AUTHOR: [Cerlo, Blizzow]
--- MOD_DESCRIPTION: A remake of Blizzow's Themed Jokers
--- PREFIX: Themed
--- BADGE_COLOR: 8247A5
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.3.1

-- MOD SETTINGS
THEMED = {
    Debug = false,
    CombatAces = true,
    Cosmic = true,
    Mischievous = true,
    Omen = true
}

-- UTIL
local ATLAS = SMODS.load_file('Util/Atlas.lua')()
local LOCALIZATION = SMODS.load_file('Util/Localization.lua')()

-- JOKERS
local JOKERS = SMODS.load_file('Jokers/[LOADER].lua')()

-- DECKS
local DECKS = SMODS.load_file('Decks/[LOADER].lua')()

-- TAROTS
local TAROTS = SMODS.load_file('Tarots/[LOADER].lua')()

-- MODS COMPATIBILITY
local MODS = SMODS.load_file('Mods Compatibility/[LOADER].lua')()