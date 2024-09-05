local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Second Piece of the Mischievous One
    key = 'MO-SecondPiece',
    loc_txt = {
        ['default'] = {
            name = 'Second Piece of the Mischievous One',
            text = {
                '{C:mult}+#1#{} Mult',
                'Gains {C:mult}+1{} for every',
                '{C:attention}The Mischievous One{} Joker'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if card.area == G.jokers then
            return {vars = {UTIL.countMischievous()}}
        else
            return {vars = {1}}
        end
    end,
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 2, y = 1},
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Mischievous = 'Second',
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