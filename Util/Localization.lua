function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other['Themed_Tokens'] = {
        name = 'Cosmic Tokens',
		text = {
            '{C:purple}+1 Cosmic Token',
            'per {C:attention}#1#{} scored',
            '{C:inactive}({C:purple}Cosmic Tokens{C:inactive}: {X:purple,C:white}#2#{C:inactive})'
        }
	}
    G.localization.descriptions.Other['Themed_Tokens_Ophiuchus'] = {
        name = 'Cosmic Tokens',
		text = {
            '{C:purple}+3 Cosmic Tokens',
            'per {C:attention}#1#{} scored',
            '{C:inactive}({C:purple}Cosmic Tokens{C:inactive}: {X:purple,C:white}#2#{C:inactive})'
        }
	}
    G.localization.descriptions.Other['Themed_Total_Tokens'] = {
        name = 'Total Cosmic Tokens',
		text = {
            '{C:purple}Total Cosmic Tokens{C:inactive}: {X:purple,C:white}#1#'
        }
	}
end