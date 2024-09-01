SMODS.Joker { -- Combat Ace - Supplies
    key = 'CA-Supplies',
    loc_txt = {
        ['default'] = {
            name = 'Supplies',
            text = {
                'For every {C:red}3 discarded',
                '{C:attention}Aces{} get {C:money}$#1#.',
                'Increases by {C:money}$1{} every trigger',
                '{C:inactive}(Next supply drop in: #2#)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {card.ability.extra.Dollars, card.ability.extra.Counter}}
        else
            return {vars = {3, 3}}
        end
    end,
    config = {extra = {Dollars = 3, Counter = 3}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 2, y = 0},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Supplies',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.discard and not context.other_card.debuff then
            if context.other_card:get_id() == 14 then
                -- COUNTER DOWN
                card.ability.extra.Counter = card.ability.extra.Counter - 1
                -- CHECK SUPPLY DROP
                if card.ability.extra.Counter <= 0 then
                    card.ability.extra.Counter = 3
                    ease_dollars(card.ability.extra.Dollars)
                    card.ability.extra.Dollars = card.ability.extra.Dollars + 1
                    return {
                        message = 'Supply drop!',
                        colour = G.C.MONEY,
                        card = context.blueprint_card or card
                    }
                else
                    return {
                        message = 'Supplies up!',
                        colour = G.C.MONEY,
                        card = context.blueprint_card or card
                    }
                end
            end
        end
    end,
}