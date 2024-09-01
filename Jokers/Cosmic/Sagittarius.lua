local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Sagittarius
    key = 'C-Sagittarius',
    loc_txt = {
        ['default'] = {
            name = 'Sagittarius',
            text = {
                'Gains {C:mult}+1{} Mult',
                'per {C:purple}Cosmic Token{} on',
                'all your {C:purple}Cosmic Jokers',
                '{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 'King'
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            end
            return {vars = {card.ability.extra.Mult + UTIL.countCosmicTokens()}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {0}}
            return {vars = {10}}
        end
    end,
    config = {extra = {Tokens = 0, Mult = 10}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 11, y = 2},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 13,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.joker_main then
            local Mult = card.ability.extra.Mult + UTIL.countCosmicTokens()
            return {
                message = localize{type='variable',key='a_mult',vars={Mult}},
                mult_mod = Mult
            }
        end
    end
}