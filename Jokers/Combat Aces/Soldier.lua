local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Combat Ace - Soldier
    key = 'CA-Soldier',
    loc_txt = {
        ['default'] = {
            name = 'Soldier',
            text = {
                'Each scored {C:attention}Ace',
                'adds {C:chips}+#1#{} Chips',
                '{C:inactive}(Survived #2# rounds)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {card.ability.extra.Chips, card.ability.extra.Rounds}}
        else
            return {vars = {35, 0}}
        end
    end,
    config = {extra = {Chips = 35, Rounds = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 0},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Soldier',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        local CHIPS = card.ability.extra.Chips
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    message = localize{type='variable',key='a_chips',vars={CHIPS}},
                    chips = CHIPS,
                    card = card
                }
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            card.ability.extra.Rounds = card.ability.extra.Rounds + 1
            if card.ability.extra.Rounds >= 15 then
                UTIL.destroyJoker(card)
                UTIL.createJoker('j_Themed_CA-Veteran',{negative = true})
                return {
                    message = 'Promoted!',
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
}