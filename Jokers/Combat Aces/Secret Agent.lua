local function OtherJokerCalc(card)
    local otherJoker = nil
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            return G.jokers.cards[i+1]
        end
    end
end

SMODS.Joker { -- Combat Ace - Secret Agent
    key = 'CA-SecretAgent',
    loc_txt = {
        ['default'] = {
            name = 'Secret Agent',
            text = {
                'Copies the effect of the',
                '{C:attention}Combat Ace{} to its right',
                'Currently copies: {C:green}#1#'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {card.ability.extra.Name}}
        else
            return {vars = {'Nothing'}}
        end
    end,
    config = {extra = {Name = 'Nothing'}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 1, y = 0},
    atlas = 'Jokers',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Secret Agent',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        -- CALCULATE NEXT JOKER
        local otherJoker = OtherJokerCalc(card)
        -- UPDATE NAME AND JOKER CALC
        if otherJoker and otherJoker.config.center.CombatAce then
            card.ability.extra.Name = otherJoker.config.center.SecretAgentName
            context.blueprint = true
            context.blueprint_card = context.blueprint_card or card
            local ret = otherJoker:calculate_joker(context)
            if ret then
                ret.card = context.blueprint_card or card
                return ret
            end
        else
            card.ability.extra.Name = 'Nothing'
        end
    end,
}