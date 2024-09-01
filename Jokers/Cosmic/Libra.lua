local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Libra
    key = 'C-Libra',
    loc_txt = {
        ['default'] = {
            name = 'Libra',
            text = {
                'Adds {C:mult}+1%{} chip value of scored',
                'card as Mult per {C:purple}Cosmic Token',
                'on all your {C:purple}Cosmic Jokers',
                '{C:inactive}(Currently {C:mult}#1#% {C:inactive}chip value)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 'Jack'
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
                info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {UTIL.countCosmicTokens()}}
            end
            return {vars = {20 + UTIL.countCosmicTokens()}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            info_queue[#info_queue + 1] = {key = 'Themed_Total_Tokens', set = 'Other', vars = {0}}
            return {vars = {20}}
        end
    end,
    config = {extra = {Tokens = 0, Percent = 20}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 9, y = 2},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 11,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.individual and context.cardarea == G.play and not context.repetition then
            local Percent = card.ability.extra.Percent + UTIL.countCosmicTokens()
            local Mult = math.floor(context.other_card:get_chip_bonus() * Percent / 100)
            print('Percent: '..Percent..', Mult: '..Mult)
            if Mult > 0 then
                return {
                    message = localize{type='variable',key='a_mult',vars={Mult}},
                    colour = G.C.RED,
                    mult = Mult,
                    card = context.blueprint_card or card
                }
            end
        end
    end
}