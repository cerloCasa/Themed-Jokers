local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Back {
    key = 'MischievousDeck',
    loc_txt = {
        name = 'Deck of the Mischievous One',
        text = {
            'Start the game with one',
            '{C:attention}Cultist of the Mischievous One'
        }
    },
    config = {},
    pos = {x = 1, y = 0},
    atlas = 'Decks',
    unlocked = true,
    discovered = true,
    apply = function(self)
        UTIL.createJoker('j_Themed_MO-Cultist')
    end,
    trigger_effect = function(self, args)
    end
}