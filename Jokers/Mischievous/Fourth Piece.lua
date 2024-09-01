local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Fourth Piece of the Mischievous One
    key = 'MO-FourthPiece',
    loc_txt = {
        ['default'] = {
            name = 'Fourth Piece of the Mischievous One',
            text = {
                '{C:mult}+#1#{} Mult',
                'Gains {C:mult}+1{} for every',
                '{C:attention}The Mischievous One{} Joker'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and card.area == G.jokers then
            return {vars = {UTIL.countMischievous()}}
        else
            return {vars = {1}}
        end
    end,
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 4, y = 1},
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Mischievous = 'Fourth',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                message = localize{type = 'variable', key = 'a_mult', vars = {UTIL.countMischievous()}},
                mult_mod = UTIL.countMischievous(),
                card = context.blueprint_card or card
            }
        end
    end,
}