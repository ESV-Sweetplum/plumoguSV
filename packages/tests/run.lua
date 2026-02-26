function runTest(testName, expr, res)
    if expr then
        print('Test ' .. testName:upper() .. ' was successful.')
    else
        print('\nTest ' .. testName:upper() .. ' failed.\n')
        print(json.stringify(res))
    end
end
