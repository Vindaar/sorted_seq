import ../sorted_seq

let values = toSortedSeq(@[1, 3, 2, 2])
var collected: seq[int]
for value in values:
  collected.add value
doAssert collected == @[3, 2, 2, 1]

var indexed: seq[(int, int)]
for index, value in values:
  indexed.add (index, value)
doAssert indexed == @[(0, 3), (1, 2), (2, 2), (3, 1)]
