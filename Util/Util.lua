local UTIL = {}

function UTIL.showMessage(args) -- args{card, message, colour}
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card_eval_status_text(args.card, 'extra', nil, nil, nil, {message = args.message, colour = args.colour, instant=true})
            return true
        end
    }))
end

function UTIL.createJoker(key,edition,forced)
    if THEMED.Debug then
        print("Creating Joker: " .. key)
    end
    G.E_MANAGER:add_event(Event({
        func = function() 
            if forced or (edition and edition.negative) or (#G.jokers.cards < G.jokers.config.card_limit) then
                local _card = create_card('Joker',G.jokers, nil, nil, nil, edition, key)
                _card:start_materialize()
                _card:add_to_deck()
                if edition then
                    _card:set_edition(edition)
                end
                G.jokers:emplace(_card)
            else
                if THEMED.Debug then
                    print("Cannot create Joker: "..key.." because there is no room")
                end
            end
            return true;
        end}))
end

function UTIL.destroyJoker(card)
    if THEMED.Debug then
        print("Removing Joker: "..card.config.center_key)
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true;
        end}))
end

function UTIL.createConsumeable(args) -- args{key,set,edition}
    if args.key == 'lastHandPlayed' then
        G.E_MANAGER:add_event(Event({
            func = function()
                local canCreate = (args.edition and args.edition.negative) or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)
                if canCreate and G.GAME.last_hand_played then
                    local _planet = 0
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end
                    local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet)
                    _card.ability.qty = 1
                    _card:set_edition(args.edition)
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
                return true;
            end}))
    else
        G.E_MANAGER:add_event(Event({
            func = function() 
                local canCreate = (args.edition and args.edition.negative) or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)
                if canCreate then
                    local _card = create_card(args.set, G.consumeables, nil, nil, nil, nil, args.key)
                    _card.ability.qty = 1
                    _card:set_edition(args.edition)
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            return true;
        end}))
    end
    if THEMED.Debug then
        print(args.set.." created")
    end
end

function UTIL.random(prob,total)
    -- This function returns true with a (prob) in (total) chance
    prob = prob * (G.GAME and G.GAME.probabilities.normal or 1)
    if (prob >= total) then
        if THEMED.Debug then
            print("PROB: "..prob.." in "..total.." is FORCED TRUE")
        end
        return true
    end
    if (pseudorandom('THEMED')) <= (prob/total) then
        if THEMED.Debug then
            print("PROB: "..prob.." in "..total.." is TRUE")
        end
        return true
    end
    if THEMED.Debug then
        print("PROB: "..prob.." in "..total.." is FALSE")
    end
    return false
end

function UTIL.randomInt(N)
    local INT = math.ceil(N*pseudorandom(pseudoseed('THEMED')))
    if THEMED.Debug then
        print("Random number from 1 to "..N.." is "..INT)
    end
    return INT
end

function UTIL.randomFromTable(args)
    local table = args.table
    local filter = args.filter
    if not table then
        if THEMED.Debug then
            print('Table is nil')
        end
        return
    end
    -- FILTERING
    local items = {}
    for k,v in pairs(table) do
        local canAdd = true
        if filter then
            for k1,v1 in pairs(filter) do
                if v.key == v1 then
                    canAdd = false
                end
            end
        end
        if canAdd then
            items[#items + 1] = v
        end
    end
    return items[UTIL.randomInt(#items)]
end

function UTIL.addJokerSlots(amt)
    G.jokers.config.card_limit = G.jokers.config.card_limit + amt
end

function UTIL.addConsumeableSlots(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + amount
        return true;
    end}))
end

function UTIL.countMischievous(args)
    local count = 0
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.Mischievous then
            count = count + 1
        end
    end
    return count
end

function UTIL.partsMischievous()
    local Parts = {
        First = false,
        Second = false,
        Third = false,
        Fourth = false,
        Cultist = false
    }
    for k,v in ipairs(G.jokers.cards) do
        local MISCHIEVOUS = v.config.center.Mischievous
        if MISCHIEVOUS and MISCHIEVOUS ~= 'Jimbo' and not Parts[MISCHIEVOUS] then
            Parts[MISCHIEVOUS] = k
        end
    end
    return Parts
end

function UTIL.canEvolveMischievous()
    local Parts = UTIL.partsMischievous()
    for k,v in pairs(Parts) do
        if not v then
            return false
        end
    end
    return Parts
end

function UTIL.checkOphiuchus()
    for k,v in pairs(G.jokers.cards) do
        if v.config.center.key == 'j_Themed_C-Ophiuchus' then
            return true
        end
    end
    return false
end

function UTIL.gainToken(args)
    local card = args.card
    local context = args.context
    -- CHECK IF IS ACTIVE
    if not (context.individual and context.cardarea == G.play) then
        return false
    end
    if context.repetition then
        return false
    end
    if context.other_card:get_id() ~= card.config.center.Cosmic then
        return false
    end
    print('Gaining token')
    local increment = 1
    -- CHECK FOR OPHIUCHUS
    if UTIL.checkOphiuchus() then
        increment = 3
    end

    card.ability.extra.Tokens = card.ability.extra.Tokens + increment
    UTIL.showMessage{card = card, message = ('+'..increment..' Tokens!'), colour = G.C.PURPLE}
    return true
end

function UTIL.countCosmicTokens()
    local tokens = 0
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.Cosmic then
            tokens = tokens + v.ability.extra.Tokens
        end
    end
    return tokens
end

function UTIL.allCosmicGainToken(increment)
    if UTIL.checkOphiuchus() then
        increment = 3 * increment
    end
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.Cosmic then
            v.ability.extra.Tokens = v.ability.extra.Tokens + increment
            UTIL.showMessage{card = v, message = '+'..increment..' Tokens!', colour = G.C.PURPLE}
        end
    end
end

function UTIL.checkKarma(card,forced)
    if not card.config.center.Omen then
        return
    end
    if forced == 'Good' then
        card.config.center.Omen = 'Good'
        UTIL.goodKarma(card)
        return    
    end
    if forced == 'Bad' then
        card.config.center.Omen = 'Bad'
        UTIL.badKarma(card)
        return    
    end
    local GoodOdds = card.ability.extra.GoodOdds
    if UTIL.random(1,GoodOdds) then
        card.config.center.Omen = 'Good'
        UTIL.goodKarma(card)
        return
    end
    local BadOdds = card.ability.extra.BadOdds
    if UTIL.random(1,BadOdds) then
        card.config.center.Omen = 'Bad'
        UTIL.badKarma(card)
        return
    end
    card.config.center.Omen = true
end

function UTIL.goodKarma(card)
    if THEMED.Debug then
        print(card.config.center.key..' triggered Good Karma')
    end
    UTIL.showMessage{card = card, message = 'Good Karma!', colour = G.C.GREEN}
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_Themed_O-Seven' then
            v.ability.extra.XMult = v.ability.extra.XMult + 0.25
            UTIL.showMessage{card = v, message = localize{type = 'variable', key = 'a_xmult', vars = {v.ability.extra.XMult}}, colour = G.C.RED}
        end
    end
end

function UTIL.badKarma(card)
    if THEMED.Debug then
        print(card.config.center.key..' triggered Bad Karma')
    end
    UTIL.showMessage{card = card, message = 'Bad Karma!', colour = G.C.RED}
    for k,v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_Themed_O-Thirteen' then
            v.ability.extra.XMult = v.ability.extra.XMult + 0.25
            UTIL.showMessage{card = v, message = localize{type = 'variable', key = 'a_xmult', vars = {v.ability.extra.XMult}}, colour = G.C.RED}
        end
    end
end

return UTIL