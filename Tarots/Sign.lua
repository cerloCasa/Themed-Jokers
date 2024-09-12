local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Consumable {
    key = 'C-Sign',
    loc_txt = {
        name = 'The Sign',
        text = {
            'All {C:purple}Cosmic Jokers{} gain {C:purple}+10 Cosmic Tokens',
            'If you have {C:purple}150 Cosmic Tokens{} or more,',
            'create a {C:dark_edition}negative {C:legendary}Ophiuchus',
        }
    },
    loc_vars = function(self, info_queue, card)
        if not card or card.area == G.shop_jokers or card.area == G.consumeables or card.area == G.pack_cards then
            if UTIL.checkOphiuchus() then
                return {set = 'Tarot', key = 'Themed_Sign_Ophiuchus'}
            end
        end
    end,
    config = {extra = {Tokens = 10, OphiuchusTokens = 150}},
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 2, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    in_pool = function(self)
        for k,v in ipairs(G.jokers.cards) do
            if v.config.center.Cosmic then
                return true
            end
        end
        return false
    end,
    can_use = function()
        return true    
    end,
    use = function(self, area, copier)
        local Tokens = self.config.extra.Tokens
        UTIL.allCosmicGainToken(Tokens)
        print('Total Tokens = '..UTIL.countCosmicTokens())
        if UTIL.countCosmicTokens() >= 150 and not UTIL.checkOphiuchus() then
            UTIL.createJoker('j_Themed_C-Ophiuchus',{negative = true})
        end
    end
}