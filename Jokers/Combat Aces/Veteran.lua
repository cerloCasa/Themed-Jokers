SMODS.Joker { -- Combat Ace - Veteran
    key = 'CA-Veteran',
    loc_txt = {
        ['default'] = {
            name = 'Veteran',
            text = {
                'Each scored {C:attention}Ace{} retriggers',
                'and gives {C:chips}+#1#{} Chips.',
                'Increases by {C:chips}#2#{} every round',
                '{C:inactive}(Survived #3# rounds)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {card.ability.extra.Chips, card.ability.extra.Increment, card.ability.extra.Rounds}}
        else
            return {vars = {50, 10, 0}}
        end
    end,
    config = {extra = {Chips = 50, Rounds = 0, Increment = 10}},
    rarity = 4, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 7, y = 0},
    atlas = 'Jokers',
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Veteran',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.Chips}},
                    chips = card.ability.extra.Chips,
                    card = context.blueprint_card or card
                }
            end
        end
        if  context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            card.ability.extra.Rounds = card.ability.extra.Rounds + 1
            card.ability.extra.Chips = card.ability.extra.Chips + card.ability.extra.Increment
            return {
                message = 'Aged Up!',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end,
}