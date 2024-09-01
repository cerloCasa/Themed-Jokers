local UTIL = SMODS.load_file('Util/Util.lua')()

THEMED.MISCHIEF = {
    [1] = 'j_Themed_MO-FirstPiece',
    [2] = 'j_Themed_MO-SecondPiece',
    [3] = 'j_Themed_MO-ThirdPiece',
    [4] = 'j_Themed_MO-FourthPiece',
    [5] = 'j_Themed_MO-Cultist',
}

SMODS.Consumable {
    key = 'MO-Mischief',
    loc_txt = {
        name = 'Mischief',
        text = {
            'Creates a {C:attention}Piece of the Mischievous One',
            'or {C:attention}Cultist of the Mischievous One',
            '{C:inactive}(Must have room)'
        }
    },
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 0, y = 1},
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
        UTIL.createJoker(THEMED.MISCHIEF[UTIL.randomInt(5)])
    end
}