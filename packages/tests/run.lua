require('packages.table.stringify')

function runTest(testName, expr, res)
    if expr then
        print('Test ' .. testName:upper() .. ' was successful.')
    else
        print('\nTest ' .. testName:upper() .. ' failed.\n')
        print(table.stringify(res))
    end
end
