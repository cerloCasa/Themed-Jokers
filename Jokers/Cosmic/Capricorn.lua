local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Capricorn
    key = 'C-Capricorn',
    loc_txt = {
        ['default'] = {
            name = 'Capricorn',
            text = {
                'Scored cards gain',
                '{C:chips}+#1#{} Chips permanently'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        local SCORINGCARD = 2
        if G.GAME and card.area == G.jokers then
            if UTIL.checkOphiuchus() then
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens_Ophiuchus', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            else
                info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, card.ability.extra.Tokens}}
            end
            return {vars = {card.ability.extra.Chips}}
        else
            info_queue[#info_queue + 1] = {key = 'Themed_Tokens', set = 'Other', vars = {SCORINGCARD, 0}}
            return {vars = {3}}
        end
    end,
    config = {extra = {Tokens = 0, Chips = 3}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 2},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Cosmic = 2,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        UTIL.gainToken{card = card, context = context}

        if context.individual and context.cardarea == G.play and not context.repetition then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.Chips
            return {
                extra = {message = 'Cosmic Upgrade!', colour = G.C.PURPLE},
                colour = G.C.PURPLE,
                card = card
            }
        end
    end,
}