local UTIL = SMODS.load_file('Util/Util.lua')()

THEMED.COJOKERS = {
    [1] = 'j_Themed_C-Capricorn',
    [2] = 'j_Themed_C-Aquarius',
    [3] = 'j_Themed_C-Pisces',
    [4] = 'j_Themed_C-Aries',
    [5] = 'j_Themed_C-Taurus',
    [6] = 'j_Themed_C-Gemini',
    [7] = 'j_Themed_C-Cancer',
    [8] = 'j_Themed_C-Leo',
    [9] = 'j_Themed_C-Virgo',
    [10] = 'j_Themed_C-Libra',
    [11] = 'j_Themed_C-Scorpio',
    [12] = 'j_Themed_C-Sagittarius'
}

SMODS.Consumable {
    key = 'C-Cosmos',
    loc_txt = {
        name = 'The Cosmos',
        text = {
            'Creates a random',
            '{C:purple}Cosmic Joker',
            '{C:inactive}(Must have room)'
        }
    },
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 1, y = 0},
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
        UTIL.createJoker(THEMED.COJOKERS[UTIL.randomInt(12)])
    end
}