local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Mirror Shard
    key = 'O-MirrorShard',
    loc_txt = {
        ['default'] = {
            name = 'Mirror Shard',
            text = {
                'When selecting a {C:attention}blind:',
                '{C:green}#1# in #2#{} chance to turn into',
                '{C:attention}Broken Mirror',
                '{C:red}#1# in #3#{} chance to get {C:red}destroyed'
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
            return {vars = {1, 3, 3}}
        end
    end,
    config = {extra = {GoodOdds = 3, BadOdds = 3}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 1, y = 4},
    atlas = 'Jokers',
    cost = 2,
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
                UTIL.destroyJoker(card)
                UTIL.createJoker('j_Themed_O-BrokenMirror')
            end
            if card.config.center.Omen == 'Bad' then
                UTIL.destroyJoker(card)
            end
        end
    end,
}