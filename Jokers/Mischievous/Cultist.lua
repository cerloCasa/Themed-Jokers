local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Joker { -- Cultist
    key = 'MO-Cultist',
    loc_txt = {
        ['default'] = {
            name = 'Cultist of the Mischievous One',
            text = {
                'When selecting a {C:attention}Blind{}, creates 1 {C:attention}\"Piece of the Mischievous One\"',
                'Gains {X:mult,C:white}X0.2{} Mult for every {C:attention}\"Mischievous\" Joker',
                'At the end of the Round, if you have all {C:attention}4{} pieces, {C:red}destroys{}',
                'them and itself and creates 1 {C:legendary}Jimbo the Mischievous One',
                '{C:inactive}(Must have room) (Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
            },
        },
    },
    loc_vars = function(self, info_queue, card)
        if card.area == G.jokers then
            local XMult = 1 + 0.2 * UTIL.countMischievous()
            return {vars = {XMult}}
        else
            return {vars = {1.2}}
        end
    end,
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 5, y = 1},
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    Mischievous = 'Cultist',
    calculate = function(self,card,context)
        if context.joker_main then
            local XMult = 1 + 0.2 * UTIL.countMischievous()
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {XMult}},
                Xmult_mod = XMult,
                card = context.blueprint_card or card
            }
        end
        if context.setting_blind then
            local Parts = UTIL.partsMischievous()
            if not Parts['j_Themed_MO-FirstPiece'] then
                UTIL.createJoker('j_Themed_MO-FirstPiece')
            elseif not Parts['j_Themed_MO-SecondPiece'] then
                UTIL.createJoker('j_Themed_MO-SecondPiece')
            elseif not Parts['j_Themed_MO-ThirdPiece'] then
                UTIL.createJoker('j_Themed_MO-ThirdPiece')
            elseif not Parts['j_Themed_MO-FourthPiece'] then
                UTIL.createJoker('j_Themed_MO-FourthPiece')
            else
                UTIL.createJoker('j_Themed_MO-FirstPiece')
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            local Parts = UTIL.canEvolveMischievous()
            if Parts then
                for k,v in pairs(Parts) do
                    UTIL.destroyJoker(G.jokers.cards[v])
                end
                UTIL.createJoker('j_Themed_MO-Jimbo')
                return {
                    message = 'HE RETURNS ONCE MORE!',
                    colour = G.C.LEGENDARY,
                    card = card
                }
            end
        end
    end,
}