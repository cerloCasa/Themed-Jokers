local UTIL = SMODS.load_file('Util/Util.lua')()

THEMED.CAJOKERS = {
    [1] = 'j_Themed_CA-General',
    [2] = 'j_Themed_CA-Mercenary',
    [3] = 'j_Themed_CA-Promotion',
    [4] = 'j_Themed_CA-Recruiter',
    [5] = 'j_Themed_CA-SecretAgent',
    [6] = 'j_Themed_CA-Soldier',
    [7] = 'j_Themed_CA-Supplies',
    [8] = 'j_Themed_CA-Veteran'
}

SMODS.Consumable {
    key = 'CA-Contract',
    loc_txt = {
        name = 'The Contract',
        text = {
            'Creates a random',
            '{C:attention}Combat Ace Joker',
            '{C:inactive}(Must have room)'
        }
    },
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 1, y = 1},
    cost = 3,
    unlocked = true,
    discovered = false,
    can_use = function()
        if (#G.jokers.cards or 0) < G.jokers.config.card_limit then
            return true
        else
            return false
        end
    end,
    use = function(self, area, copier)
        UTIL.createJoker(THEMED.CAJOKERS[UTIL.randomInt(8)])
    end
}