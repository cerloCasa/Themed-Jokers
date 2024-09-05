local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Aries
    key = 'C-Aries',
    loc_txt = {
        ['default'] = {
            name = 'Aries',
            text = {
                'Gains {C:chips}+10{} Chips',
                'per {C:purple}Cosmic Token',
                '{C:inactive}(Currently {C:chips}+#1# {C:inactive}Chips)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 5
        if card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {card.ability.extra.Chips + 10 * card.ability.extra.Tokens}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {30}}
        end
    end,
    config = {extra = {Tokens = 0, Chips = 30}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 3, y = 2},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 5,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.joker_main then
            local chips = card.ability.extra.Chips + 10 * card.ability.extra.Tokens
            return {
                message = localize{type='variable', key='a_chips', vars={chips}},
                chip_mod = chips
            }
        end
    end,
}