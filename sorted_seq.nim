import algorithm, typetraits

## The implementation provides a sorted sequence where the last element
## is always the smallest element.

type
  SortedSeq*[T] = distinct seq[T]

proc initSortedSeq*[T](len: int = 0): SortedSeq[T] =
  result = SortedSeq[T](newSeqOfCap[T](len))

proc len*[T](ss: SortedSeq[T]): int = distinctBase(ss).len
proc high*[T](ss: SortedSeq[T]): int = distinctBase(ss).high
proc setLen*[T](ss: var SortedSeq[T], newLen: int) = distinctBase(ss).setLen(newLen)

proc `[]`*[T](ss: SortedSeq[T], i: int): T = distinctBase(ss)[i]

proc toSortedSeq*[T](d: seq[T]): SortedSeq[T] =
  result = SortedSeq(d.sorted(SortOrder.Descending))

proc findIdx*[T](ss: SortedSeq[T], p: T): int =
  ## Find the correct index for `p` in `ss` to insert (i.e. like `lowerBound`)
  result = 0
  var count = ss.len
  var step, pos: int
  while count != 0:
    step = count shr 1
    pos = result + step
    if cmp(ss[pos], p) >= 0:
      result = pos + 1
      count -= step + 1
    else:
      count = step

proc push*[T](ss: var SortedSeq[T], p: T) =
  ## Inserts element `p` at the correct position such that `ss` remains ordered
  let idx = findIdx(ss, p)
  distinctBase(ss).insert(p, idx)

proc pop*[T](ss: var SortedSeq[T]): T =
  ## Returns the smallest (if SortOrder.Descending!) element in `ss`, i.e. the last element.
  result = ss[ss.high]
  ss.setLen(ss.high)

iterator items*[T](ss: SortedSeq[T]): T =
  for d in items(ss):
    yield d

iterator pairs*[T](ss: SortedSeq[T]): (int, T) =
  for i, d in pairs(ss):
    yield (i, d)

proc `$`*[T](ss: SortedSeq[T]): string = $(distinctBase(ss))
