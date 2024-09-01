local UTIL = SMODS.load_file('Util/Util.lua')()

local function turnScoringHandIntoLucky(context)
    local lucky = G.P_CENTERS.m_lucky
    for k,card in ipairs(context.scoring_hand) do
        if card.config.center.key ~= 'm_lucky' then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card:flip()
                    play_sound('card1', 5)
                    card:juice_up(0.3, 0.3)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card:flip()
                    play_sound('tarot1', 5)
                    card:set_ability(lucky)
                    return true
                end
            })) 
        end
    end
end

SMODS.Joker { -- Black Cat
    key = 'O-BlackCat',
    loc_txt = {
        ['default'] = {
            name = 'Black Cat',
            text = {
                '{C:green}#1# in #2#{} chance to turn',
                'scored hand into {C:attention}Lucky Cards',
                '{C:red}#1# in #3#{} chance to {C:red}lose',
                '{C:money}2${} after scoring'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME then
            local Chance = G.GAME.probabilities.normal or 1
            local GoodOdds = card.ability.extra.GoodOdds
            local BadOdds = card.ability.extra.BadOdds
            return {vars = {Chance, GoodOdds, BadOdds}}
        else
            return {vars = {1, 6, 4}}
        end
    end,
    config = {extra = {GoodOdds = 6, BadOdds = 4}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 4, y = 4},
    atlas = 'Jokers',
    cost = 8,
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
        if context.after then
            UTIL.checkKarma(card)
            if card.config.center.Omen == 'Good' then
                turnScoringHandIntoLucky(context)
            end
            if card.config.center.Omen == 'Bad' then
                ease_dollars(-2)
            end
        end
    end,
}