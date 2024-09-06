local UTIL = SMODS.load_file('Util/Util.lua')()

SMODS.Consumable {
    key = 'C-Constellation',
    loc_txt = {
        name = 'The Constellation',
        text = {
            'Up to {C:attention}3{} selected cards gain',
            '{C:chips}+15{} Chips permanently',
            'All {C:purple}Cosmic Jokers{} gain',
            '{C:purple}+5 Cosmic Tokens'
        }
    },
    config = {extra = {MaxHighlighted = 3, Chips = 15, Tokens = 5}},
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 0, y = 0},
    cost = 4,
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
        local MaxHighlighted = 3
        if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
            if MaxHighlighted then
                if #G.hand.highlighted <= MaxHighlighted then
                    return true
                end
            end
        end         
    end,
    use = function(self, area, copier)
        local Chips = self.config.extra.Chips
        local Tokens = self.config.extra.Tokens
        UTIL.allCosmicGainToken(Tokens)
        for k,v in ipairs(G.hand.highlighted) do
            v.ability.perma_bonus = (v.ability.perma_bonus or 0) + Chips
            UTIL.showMessage{card = v, message = 'Cosmic Upgrade!', colour = G.C.PURPLE}
        end
    end
}