import strutils, sequtils

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

proc check_that_adjacent_is_only_a_pair*(list: seq[char]): bool =
    # This is bad but it works
    var i: int = 0
    result = false
    while i < 5:
        if i == 0 and parseInt($list[i]) == parseInt($list[i+1]) and parseInt($list[i]) != parseInt($list[i+2]):
            result = true
            break;
        elif i == 4 and parseInt($list[i]) == parseInt($list[i+1]) and parseInt($list[i]) != parseInt($list[i-1]):
            result = true
            break;
        elif i == 4:
            result = false
            break
        elif parseInt($list[i]) == parseInt($list[i+1]) and parseInt($list[i]) != parseInt($list[i+2]) and parseInt($list[i]) != parseInt($list[i-1]):
            result = true
            break;
        i += 1

when isMainModule:
    echo check_that_adjacent_is_only_a_pair(toSeq("111122".items))