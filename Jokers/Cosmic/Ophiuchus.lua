local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Ophiuchus
    key = 'C-Ophiuchus',
    loc_txt = {
        ['default'] = {
            name = 'Ophiuchus',
            text = {
                'Gains {X:mult,C:white}X0.01{} Mult',
                'per {C:purple}Cosmic Token{} on',
                'all your {C:purple}Cosmic Jokers',
                '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                '{C:purple}Cosmic Jokers{} gain 3X',
                'as many {C:purple}Cosmic Tokens'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            end
            return {vars = {card.ability.extra.XMult + 0.01 * UTIL.countCosmicTokens()}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {0}}
            return {vars = {1}}
        end
    end,
    config = {extra = {XMult = 1}},
    rarity = 4, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 12, y = 2},
    atlas = 'Jokers',
    cost = 35,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local XMult = card.ability.extra.XMult + 0.01 * UTIL.countCosmicTokens()
            return {
                message = localize{type='variable',key='a_xmult',vars={XMult}},
                Xmult_mod = XMult
            }
        end
    end
}