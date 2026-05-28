function listenForGeneralChanges()
    listen(function() cache.set('map_edited', true) end)
end
