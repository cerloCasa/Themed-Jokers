local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Aquarius
    key = 'C-Aquarius',
    loc_txt = {
        ['default'] = {
            name = 'Aquarius',
            text = {
                '{C:green}#1# in #2#{} chance',
                'to gain {C:money}$1{}',
                'per card scored'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 3
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra.Odds}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {G.GAME.probabilities.normal or 1, 6}}
        end
    end,
    config = {extra = {Tokens = 0, Odds = 6}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 1, y = 2},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 3,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.individual and context.cardarea == G.play and not context.repetition then
            if UTIL.random(1,card.ability.extra.Odds) then
                return {
                    extra = {message = 'Cosmic Money!', colour = G.C.PURPLE},
                    dollars = 1,
                    colour = G.C.PURPLE,
                    card = card
                }
            end
        end
    end,
}