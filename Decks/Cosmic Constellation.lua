local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Back {
    key = 'CosmisDeck',
    loc_txt = {
        name = 'Cosmic Constellation',
        text = {
            'Start the game with',
            '{C:purple}The Cosmos{} and',
            '{C:purple}The Sign'
        }
    },
    config = {},
    pos = {x = 2, y = 0},
    atlas = 'Decks',
    unlocked = true,
    discovered = true,
    apply = function(self)
        --
    end,
    trigger_effect = function(self, args)
    end
}