local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Gemini
    key = 'C-Gemini',
    loc_txt = {
        ['default'] = {
            name = 'Gemini',
            text = {
                'Gains {C:green}+0.5%{} chance',
                'per {C:purple}Cosmic Token',
                'to {C:attention}retrigger{} scored cards',
                '{C:inactive}(Currently {C:green}#1#% {C:inactive}chance)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 7
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {(card.ability.extra.Chance + 0.5 * card.ability.extra.Tokens) * (G.GAME.probabilities.normal or 1)}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {5 * (G.GAME.probabilities.normal or 1)}}
        end
    end,
    config = {extra = {Tokens = 0, Chance = 5}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 5, y = 2},
    atlas = 'Jokers',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 7,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.repetition and context.cardarea == G.play then
            local Chance = card.ability.extra.Chance + 0.5 * card.ability.extra.Tokens
            Chance = Chance * G.GAME.probabilities.normal
            local reps = math.floor(Chance/100)
            Chance = (Chance - 100 * reps) / G.GAME.probabilities.normal
            if UTIL.random(Chance,100) then
                reps = reps + 1
            end
            return {
                message = localize('k_again_ex'),
                repetitions = reps,
                card = card
            }
        end
    end,
}