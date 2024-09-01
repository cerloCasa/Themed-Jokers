local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Back {
    key = 'CombatAceDeck',
    loc_txt = {
        name = 'Combat Ace Conquest',
        text = {
            'Start the game with one',
            '{C:attention}Combat Ace - Soldier{} and',
            '{C:attention}Combat Ace - Recruiter'
        }
    },
    config = {},
    pos = {x = 0, y = 0},
    atlas = 'Decks',
    unlocked = true,
    discovered = true,
    apply = function(self)
        UTIL.createJoker('j_Themed_CA-Soldier')
        UTIL.createJoker('j_Themed_CA-Recruiter')
    end,
    trigger_effect = function(self, args)
    end
}