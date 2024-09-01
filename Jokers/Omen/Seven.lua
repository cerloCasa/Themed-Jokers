local UTIL = SMODS.load_file('Util/Util.lua')()

local function modifyKarma(karma, amount)
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.Omen then
            if karma == 'Good' then
                v.ability.extra.GoodOdds = math.max(v.ability.extra.GoodOdds + amount, 1)
            end
            if karma == 'Bad' then
                v.ability.extra.BadOdds = math.max(v.ability.extra.BadOdds + amount, 1)
            end
        end
    end
end

SMODS.Joker { -- Seven
    key = 'O-Seven',
    loc_txt = {
        ['default'] = {
            name = 'Seven',
            text = {
                'Gains {X:mult,C:white}0.25X{} Mult when {C:green}good effects{} activate', 
                '{C:inactive}(Currently: {X:mult,C:white}X#4#{} {C:inactive}Mult)',                              
                '{C:green}#1# in #2#{} chance {C:green}increase {C:red}Good Karma{}', 
                '{C:red}#1# in #3#{} chance {C:red}decrease {C:green}Good Karma{}',
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            local Chance = G.GAME.probabilities.normal or 1
            local GoodOdds = card.ability.extra.GoodOdds
            local BadOdds = card.ability.extra.BadOdds
            local XMult = card.ability.extra.XMult
            return {vars = {Chance, GoodOdds, BadOdds, XMult}}
        else
            return {vars = {1, 6, 4, 1}}
        end
    end,
    config = {extra = {GoodOdds = 6, BadOdds = 4, XMult = 1}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 8, y = 4},
    atlas = 'Jokers',
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    Omen = true,
    add_to_deck = function(self,card,from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self,card,context)
        if context.blueprint then
            return
        end
        if context.setting_blind then
            UTIL.checkKarma(card)
            if card.config.center.Omen == 'Good' then
                modifyKarma('Good', -1)
            end
            if card.config.center.Omen == 'Bad' then
                modifyKarma('Good', 1)
            end
        end
        if context.joker_main then
            local XMult = card.ability.extra.XMult
            if XMult > 1 then
                return {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {XMult}},
                    XMult_mod = XMult,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
}