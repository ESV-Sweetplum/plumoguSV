function checkForGlobalHotkeys()
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[9])) then jumpToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[10])) then changeNoteLockMode() end
end
