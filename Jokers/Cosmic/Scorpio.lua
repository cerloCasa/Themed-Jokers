local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Scorpio
    key = 'C-Scorpio',
    loc_txt = {
        ['default'] = {
            name = 'Scorpio',
            text = {
                'Scored cards gain {C:chips}+1{} Chips',
                'permanently per {C:purple}Cosmic Token',
                'on all your {C:purple}Cosmic Jokers',
                '{C:inactive}(Currently {C:chips}+#1# {C:inactive}Chips)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 'Queen'
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            end
            return {vars = {3 + UTIL.countCosmicTokens()}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {0}}
            return {vars = {3}}
        end
    end,
    config = {extra = {Tokens = 0, Chips = 3}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 10, y = 2},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 12,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.individual and context.cardarea == G.play and not context.repetition then
            local Chips = card.ability.extra.Chips + UTIL.countCosmicTokens()
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + Chips
            return {
                extra = {message = 'Cosmic Upgrade!', colour = G.C.PURPLE},
                colour = G.C.PURPLE,
                card = card
            }
        end
    end
}