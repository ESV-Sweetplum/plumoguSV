require("packages.kbm.numToKey")

function string.obfuscate(str)
    local newStr = ""
    local originalSize = imgui.CalcTextSize(str).x
    for i = 1, str:len() do
        if (str:charAt(i) == " ") then
            newStr = newStr .. " "
        else
            newStr = newStr .. ALPHABET_LIST[math.random(1, 26)]:lower()
        end
        if (imgui.CalcTextSize(newStr).x > originalSize) then
            newStr = newStr:sub(1, -2)
            break
        end
    end

    return newStr
end
