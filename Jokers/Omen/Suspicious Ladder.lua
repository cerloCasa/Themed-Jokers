local UTIL = SMODS.load_file('Util/Util.lua')()

local function modifyBlindSize(amount)
    G.GAME.blind.chips = G.GAME.blind.chips * amount
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end

SMODS.Joker { -- Suspicious Ladder
    key = 'O-SuspiciousLadder',
    loc_txt = {
        ['default'] = {
            name = 'Suspicious Ladder',
            text = {
                'When selecting a {C:attention}blind{}:',
                '{C:green}#1# in #2#{} chance to {C:green}decrease blind size',
                '{C:red}#1# in #3#{} chance to {C:red}increase blind size',
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
    pos = {x = 2, y = 4},
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
        if context.setting_blind then
            UTIL.checkKarma(card)
            if card.config.center.Omen == 'Good' then
                modifyBlindSize(0.8)
            end
            if card.config.center.Omen == 'Bad' then
                modifyBlindSize(1.2)
            end
        end
    end,
}