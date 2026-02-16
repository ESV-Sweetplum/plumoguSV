function __toBeFunction(obtainedValue, expectedValue)
    if (type(obtainedValue) == 'number' and type(expectedValue) == 'number') then
        return math.abs(obtainedValue - expectedValue) < 1e-14
    end
    return obtainedValue == expectedValue
end

function expect(expr)
    if (type(expr) ~= 'function') then
        return {
            toBe = function(x) return __toBeFunction(x, expr), { x, expr } end,
        }
    else
        local fn = expr
        return {
            of = function(x)
                if (type(x) == 'table') then
                    return {
                        toBe = function(tbl)
                            if (#tbl ~= #x) then return false end
                            for i = 1, #tbl do
                                if (not __toBeFunction(tbl[i], fn(x[i]))) then return false, { i, tbl[i], fn(x[i]) } end
                            end
                            return true
                        end,
                    }
                else
                    return {
                        toBe = function(y) return __toBeFunction(x, fn(y)) end,
                    }
                end
            end,
        }
    end
end
