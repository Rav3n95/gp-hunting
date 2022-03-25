local Translations = {
    task = {
        process = 'Zsákmány feldolgozása',
    },

    info = {
        process = 'Feldolgozod a zsákmányt',
        reward = 'Zsákmány: %{value} db %{value2}'
    },

    error = {
        owner = 'Biztos téged illet ez a zsákmány?'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
