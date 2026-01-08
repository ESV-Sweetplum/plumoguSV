function listenForGeneralChanges()
    listen(function(_, _, _)
        cache.boolean.changeOccurred = true
    end)
end
