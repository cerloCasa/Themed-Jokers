local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Combat Ace - Mercenary
    key = 'CA-Mercenary',
    loc_txt = {
        ['default'] = {
            name = 'Mercenary',
            text = {
                'Scored {C:attention}Aces{} give {X:mult,C:white} X#1# {} Mult',
                'At the end of the round pay {C:money}$5{}',
                'If you can\'t, {C:red}destroy this Joker'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            return {vars = {card.ability.extra.XMult}}
        else
            return {vars = {1.5}}
        end
    end,
    config = {extra = {XMult = 1.5}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 3, y = 0},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'Mercenary',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        local XMULT = card.ability.extra.XMult
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={XMULT}},
                    x_mult = XMULT,
                    card = card
                }
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            if G.GAME.dollars - G.GAME.bankrupt_at >= 5 then
                ease_dollars(-5, true)
                return {
                    message = 'Payday!',
                    colour = G.C.RED,
                    card = card
                }
            else
                UTIL.destroyJoker(card)
                return {
                    message = 'Mercenary has left the party!',
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
}