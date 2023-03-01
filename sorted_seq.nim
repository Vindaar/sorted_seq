import algorithm, typetraits

type
  SortedSeq*[T] = distinct seq[T]

proc initSortedSeq*[T](len: int = 0): SortedSeq[T] =
  result = SortedSeq[T](newSeqOfCap[T](len))

proc len*[T](ss: SortedSeq[T]): int = distinctBase(ss).len
proc high*[T](ss: SortedSeq[T]): int = distinctBase(ss).high

proc `[]`*[T](ss: SortedSeq[T], i: int): T = distinctBase(ss)[i]

proc toSortedSeq*[T](d: seq[T]): SortedSeq[T] =
  result = SortedSeq(d.sorted)

proc push*[T](ss: var SortedSeq[T], p: T) =
  ## Inserts element `p` at the correct position such that `ss` remains ordered
  let idx = distinctBase(ss).lowerBound(p)
  distinctBase(ss).insert(p, idx)

iterator items*[T](ss: SortedSeq[T]): T =
  for d in items(ss):
    yield d

iterator pairs*[T](ss: SortedSeq[T]): (int, T) =
  for i, d in pairs(ss):
    yield (i, d)

proc `$`*[T](ss: SortedSeq[T]): string = $(distinctBase(ss))
