require('packages.tests.run')
require('packages.tests.expect')
require('packages.math.forceQuarter')
require('packages.math.factorial')
require('packages.math.frac')
require('packages.table.reduce')

function id(x) return x end

runTest('baseline 1', expect(5).toBe(5))
runTest('baseline 2', expect(id).of({ nil, true, 1, -5, 'hi' }).toBe({ nil, true, 1, -5, 'hi' }))
