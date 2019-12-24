import strutils, system
  
proc calculate_manhattan_distance*(first, second: (int, int)): int =
    abs(first[0] - second[0]) + abs(first[1] - second[1])

proc convert_value*(value: string): (string, int) = 
    var second = 0
    let prefixes = @["R", "U", "D", "L"]
    for thing in prefixes:
        if thing in value:
            second = parseInt(value.replace(thing))
    ($value[0], second)

proc calculate_pairs*(directions: (string, int), originx, originy: int): seq[(int, int)] =
    var newx, originx = originx
    var newy, originy = originy
    case directions[0]
    of "R":
      newx += directions[1]
      while originx <= newx:
        result.add((originx, originy))
        originx += 1
    of "U":
      newy += directions[1]
      while originy <= newy:
        result.add((originx, originy))
        originy+=1
    of "D":
      newy -= directions[1]
      while originy >= newy:
        result.add((originx, originy))
        originy-=1
    of "L":
      newx -= directions[1]
      while originx >= newx:
        result.add((originx, originy))
        originx-=1

proc build_x_and_y_values*(directions: seq[string]): seq[(int, int)] = 
    var first_current: seq[(int, int)]
    first_current.add((0, 0))
    for value in directions:
        let first_move = convert_value(value)
        first_current = calculate_pairs(first_move, first_current[len(first_current)-1][0], first_current[len(first_current)-1][1])
        for value in first_current:
          result.add(value)
