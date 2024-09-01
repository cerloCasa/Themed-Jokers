local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Combat Ace - Recruiter
    key = 'CA-Recruiter',
    loc_txt = {
        ['default'] = {
            name = 'Recruiter',
            text = {
                '{C:red}Discarded cards{} have a',
                '{C:green}#1# in #2#{} chance to',
                'become an {C:attention}Ace'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra.Odds}}
        else
            return {vars = {G.GAME.probabilities.normal or 1, 8}}
        end
    end,
    config = {extra = {Odds = 8}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 5, y = 0},
    atlas = 'Jokers',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Recruiter',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.discard then
            if context.other_card:get_id() ~= 14 and UTIL.random(1, card.ability.extra.Odds) then
                local oldCard = context.other_card
                local newCard = string.sub(oldCard.base.suit, 1, 1)..'_A'
                oldCard:set_base(G.P_CARDS[newCard])
                return {
                    message = 'Recruited!',
                    colour = G.C.CHIPS,
                    card = context.blueprint_card or card
                }
            end
        end
    end,
}