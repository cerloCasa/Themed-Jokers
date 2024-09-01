local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Pisces
    key = 'C-Pisces',
    loc_txt = {
        ['default'] = {
            name = 'Pisces',
            text = {
                'Gains {C:mult}+1{} Mult',
                'per {C:purple}Cosmic Token',
                '{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 4
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {card.ability.extra.Mult + card.ability.extra.Tokens}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {3}}
        end
    end,
    config = {extra = {Tokens = 0, Mult = 3}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 2, y = 2},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 4,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.joker_main then
            local mult = card.ability.extra.Mult + card.ability.extra.Tokens
            return {
                message = localize{type='variable', key='a_mult', vars={mult}},
                mult_mod = mult
            }
        end
    end,
}