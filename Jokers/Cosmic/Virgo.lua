local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Virgo
    key = 'C-Virgo',
    loc_txt = {
        ['default'] = {
            name = 'Virgo',
            text = {
                'Decrease blind size by {C:blue}0.1%',
                'per {C:purple}Cosmic Token{} on all',
                'your {C:purple}Cosmic Jokers',
                '{C:inactive}(Currently {C:blue}#1#% {C:inactive}decrease)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 10
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            end
            return {vars = {math.min(5 + 0.1 * UTIL.countCosmicTokens(), card.ability.extra.MaxDecrease)}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {0}}
            return {vars = {5}}
        end
    end,
    config = {extra = {Tokens = 0, Decrease = 5, MaxDecrease = 70}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 8, y = 2},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 10,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.setting_blind then
            local Decrease = card.ability.extra.Decrease
            Decrease = Decrease + 0.1 * UTIL.countCosmicTokens()
            Decrease = math.min(Decrease, card.ability.extra.MaxDecrease)
            G.GAME.blind.chips = G.GAME.blind.chips * (1 - (Decrease / 100))
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}