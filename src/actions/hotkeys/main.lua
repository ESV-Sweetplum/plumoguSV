function checkForGlobalHotkeys()
    if (kb.pressedKeyCombo(globalVars.hotkeyList[9])) then jumpToTg() end
    if (kb.pressedKeyCombo(globalVars.hotkeyList[10])) then changeNoteLockMode() end
end
