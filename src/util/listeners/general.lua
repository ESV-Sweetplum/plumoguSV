function listenForGeneralChanges()
    listen(function()
        cache.boolean.changeOccurred = true
    end)
end
