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
    config = {extra = {Tokens = 10, OphiuchusTokens = 150}},
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 2, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    can_use = function()
        return true    
    end,
    use = function(self, area, copier)
        local Tokens = self.config.extra.Tokens
        UTIL.allCosmicGainToken(Tokens)
        print('Total Tokens = '..UTIL.countCosmicTokens())
        if UTIL.countCosmicTokens() >= 150 then
            UTIL.createJoker('j_Themed_C-Ophiuchus',{negative = true})
        end
    end
}