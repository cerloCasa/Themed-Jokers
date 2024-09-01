local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Cancer
    key = 'C-Cancer',
    loc_txt = {
        ['default'] = {
            name = 'Cancer',
            text = {
                'Gains {C:green}+1%{} chance per',
                '{C:purple}Cosmic Token{} to add',
                'a {C:attention}Seal{} to discarded cards',
                '{C:inactive}(Currently {C:green}#1#% {C:inactive}chance)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 8
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {math.min((card.ability.extra.Chance + card.ability.extra.Tokens) * (G.GAME.probabilities.normal or 1),100)}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {5 * (G.GAME.probabilities.normal or 1)}}
        end
    end,
    config = {extra = {Tokens = 0, Chance = 5}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 6, y = 2},
    atlas = 'Jokers',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 8,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.discard and not context.other_card.debuff then
            if UTIL.random(card.ability.extra.Chance + card.ability.extra.Tokens, 100) then
                local seal = UTIL.randomFromTable{table = G.P_SEALS}
                local otherCard = context.other_card
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        otherCard:flip()
                        play_sound('card1', 5)
                        otherCard:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        otherCard:flip()
                        play_sound('tarot1', 5)
                        otherCard:set_seal(seal.key, nil, true)
                        return true
                    end
                }))
                return {
                    message = 'Cosmic Upgrade!',
                    colour = G.C.PURPLE,
                    card = card
                }
            end
        end
    end
}