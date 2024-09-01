SMODS.Joker { -- Combat Ace - General
    key = 'CA-General',
    loc_txt = {
        ['default'] = {
            name = 'General',
            text = {
                '{C:attention}Combat Ace{} Jokers',
                'give {X:mult,C:white}X#1#{} Mult',
                'Also counts itself'
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
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 6, y = 0},
    atlas = 'Jokers',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    CombatAce = true,
    SecretAgentName = 'General',
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.other_joker then
            if context.other_joker.config.center.CombatAce then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.XMult}},
                    Xmult_mod = card.ability.extra.XMult,
                    card = context.other_joker
                }
            end
        end
    end,
}