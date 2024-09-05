local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Jimbo the Mischievous One
    key = 'MO-Jimbo',
    loc_txt = {
        ['default'] = {
            name = 'Jimbo the Mischievous One',
            text = {
                'When selecting a {C:attention}Blind{}, destroys all',
                '{C:attention}\"Pieces of the Mischievous One\"{} you have and',
                'gains {X:mult,C:white}X1.5{} for each Joker destroyed this way',
                '{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if card.area == G.jokers then
            return {vars = {card.ability.extra.XMult}}
        else
            return {vars = {6}}
        end
    end,
    config = {extra = {XMult = 6}},
    rarity = 4, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 1},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Mischievous = 'Jimbo',
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    local increment = 0
                    for k,v in ipairs(G.jokers.cards) do
                        local KEY = v.config.center.key
                        local AcceptedKeys = {}
                        AcceptedKeys['j_Themed_MO-FirstPiece'] = true
                        AcceptedKeys['j_Themed_MO-SecondPiece'] = true
                        AcceptedKeys['j_Themed_MO-ThirdPiece'] = true
                        AcceptedKeys['j_Themed_MO-FourthPiece'] = true
                        if KEY and AcceptedKeys[KEY] then
                            v.config.center.Mischievous = nil
                            UTIL.destroyJoker(v)
                            increment = increment + 1.5
                        end
                    end
                    card.ability.extra.XMult = card.ability.extra.XMult + increment
                    if increment > 0 then
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}, colour = G.C.RED, card = card})
                    end
                    return true
                end
            }))
        end
        if context.joker_main then
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}},
                mult_mod = card.ability.extra.XMult,
                card = card
            }
        end
    end,
}