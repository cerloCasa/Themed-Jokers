if not CardSleeves then
    return
end

local UTIL = SMODS.load_file('Util/Util.lua')()

if THEMED.CombatAces then
    CardSleeves.Sleeve {
        key = 'AcesSleeve',
        loc_txt = {
            name = 'Aces Sleeve',
            text = {
                'Start the game with one',
                '{C:attention}Combat Ace - Soldier{} and',
                '{C:attention}Combat Ace - Recruiter'
            }
        },
        atlas = 'Sleeves',
        pos = {x = 0, y = 0},
        apply = function(self)
            UTIL.createJoker('j_Themed_CA-Soldier')
            UTIL.createJoker('j_Themed_CA-Recruiter')
        end
    }
end

if THEMED.Cosmic then
    CardSleeves.Sleeve {
        key = 'CosmicSleeve',
        loc_txt = {
            name = 'Cosmic Sleeve',
            text = {
                'Start the game with',
                '{C:purple}The Cosmos{} and',
                '{C:purple}The Sign'
            }
        },
        atlas = 'Sleeves',
        pos = {x = 2, y = 0},
        apply = function(self)
            UTIL.createConsumeable{key = 'c_Themed_C-Cosmos', set = 'Tarot'}
            UTIL.createConsumeable{key = 'c_Themed_C-Sign', set = 'Tarot'}
        end
    }
end

if THEMED.Mischievous then
    CardSleeves.Sleeve {
        key = 'MischievousSleeve',
        loc_txt = {
            name = 'Mischievous Sleeve',
            text = {
                'Start the game with one',
                '{C:attention}Cultist of the Mischievous One'
            }
        },
        atlas = 'Sleeves',
        pos = {x = 1, y = 0},
        apply = function(self)
            UTIL.createJoker('j_Themed_MO-Cultist')
        end
    }
end
