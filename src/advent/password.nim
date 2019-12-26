import strutils

proc check_never_decreases*(list: seq[char]): bool =
    var i: int = 0
    while i < 5:
        if parseInt($list[i]) <= parseInt($list[i+1]):
            result = true
        else:
            result = false
            break
        i += 1

proc check_adjacent_and_the_same*(list: seq[char]): bool =
    var i: int = 0
    result = false
    while i < 5:
        if parseInt($list[i]) == parseInt($list[i+1]):
            result = true
            break
        i += 1