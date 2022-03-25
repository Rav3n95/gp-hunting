local Translations = {
    task = {
        process = 'Loot',
    },

    info = {
        process = 'Processing the loot',
        reward = 'Loot: %{value} pcs %{value2}'
    },

    error = {
        owner = 'Are you sure is your loot?'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
