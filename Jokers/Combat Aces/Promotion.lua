local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Combat Ace - Promotion
    key = 'CA-Promotion',
    loc_txt = {
        ['default'] = {
            name = 'Promotion',
            text = {
                'Scoring {C:attention}Aces{} have a',
                '{C:green}#1# in #2#{} chance to',
                'become a random edition'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {G.GAME.probabilities.normal or 1,card.ability.extra.Odds}}
        else
            return {vars = {G.GAME.probabilities.normal or 1, 6}}
        end
    end,
    config = {extra = {Odds = 6}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 4, y = 0},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Promotion',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and not context.repetition then
            if context.other_card:get_id() == 14 then
                local otherCard = context.other_card
                if UTIL.random(1,card.ability.extra.Odds) then
                    if otherCard:get_edition() then
                        return
                    end
                    -- PROMOTION
                    local edition = poll_edition('THEMED', nil, true, true)
                    otherCard:set_edition(edition, true)
                end
            end
        end
    end,
}