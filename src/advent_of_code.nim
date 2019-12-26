import streams, strutils, math, advent/manhattan, advent/password, algorithm, sequtils

proc calculate_fuel*(mass: int): int =
  int(floor(mass / 3)) - 2

proc process_fuel*(mass: int): int =
  var fuel_weight = calculate_fuel(mass)
  while fuel_weight >= 0:
    result += fuel_weight
    fuel_weight = calculate_fuel(fuel_weight)

proc day_one_main_part_one*(path_to_input: string): int =
  var my_file = newFileStream(path_to_input)
  var line = ""
  if not isNil(my_file):
    while my_file.readLine(line):
      result += calculate_fuel(parseInt(line))
  my_file.close()

proc day_one_main_part_two*(path_to_input: string): int =
  var my_file = newFileStream(path_to_input)
  var line = ""
  var fuel = 0
  if not isNil(my_file):
    while my_file.readLine(line):
      fuel = process_fuel(parseInt(line))
      result += fuel
  my_file.close()

proc day_three_part_one*(path_to_values: string): int =
  var my_file = newFileStream(path_to_values)
  var line = ""
  var first_values, second_values: seq[string]
  var distances: seq[int]
  var i = 0
  if not isNil(my_file):
    while my_file.readLine(line):
      if i == 0:
        first_values = line.split(",")
      else:
        second_values = line.split(",")
      i += 1
  my_file.close()
  var first_values_x_y, second_values_x_y: seq[(int, int)]
  first_values_x_y = build_x_and_y_values(first_values)
  second_values_x_y = build_x_and_y_values(second_values)
  for value in first_values_x_y:
    if value in second_values_x_y and value != (0, 0):
      distances.add(calculate_manhattan_distance(value, (0, 0)))
  sorted(distances)[0]

proc day_three_part_two*(path_to_values: string): int =
  var my_file = newFileStream(path_to_values)
  var line = ""
  var first_values, second_values: seq[string]
  var distances: seq[int]
  var i = 0
  if not isNil(my_file):
    while my_file.readLine(line):
      if i == 0:
        first_values = line.split(",")
      else:
        second_values = line.split(",")
      i += 1
  my_file.close()
  var first_values_x_y, second_values_x_y: seq[(int, int)]
  first_values_x_y = build_x_and_y_values(first_values)
  second_values_x_y = build_x_and_y_values(second_values)
  for value in first_values_x_y:
    if value in second_values_x_y and value != (0, 0):
      distances.add(first_values_x_y.find(value) + second_values_x_y.find(value) + 2)
  sorted(distances)[0]

proc process_opcode_one(input: seq[int], value1, value2, value3: int): seq[int] =
  var list = input
  list[value3] = list[value1] + list[value2]
  list

proc process_opcode_two(input: seq[int], value1, value2, value3: int): seq[int] =
  var list = input
  list[value3] = list[value1] * list[value2]
  list

proc day_two_main_part_one*(input: seq[int], value1, value2: int): int =
  var list = input
  list[1] = value1
  list[2] = value2
  var look_at_position = 0
  while true:
    if list[look_at_position] == 1:
      list = process_opcode_one(list, list[look_at_position + 1], list[look_at_position + 2], list[look_at_position + 3])
      look_at_position += 4
    elif list[look_at_position] == 2:
      list = process_opcode_two(list, list[look_at_position + 1], list[look_at_position + 2], list[look_at_position + 3])
      look_at_position += 4
    elif list[look_at_position] == 99:
      break
    else:
      echo "broken"
  list[0]

proc day_two_main_part_two*(input: seq[int]): int =
  var list = input
  var noun, verb = 0
  var output: int
  for x in 0..99:
    noun = x
    for y in 0..99:
      verb = y
      output = day_two_main_part_one(list, noun, verb)
      if output == 19690720:
        result = 100 * noun + verb

proc day_four_part_one*(starting, ending: int): int =
  ## Returns the number of different passwords that meet the criteria between the starting and ending number.
  ##
  ## Two digits are adjacent and the same.
  ## Going from left to right, the digits never decrease.
  var starting = starting
  var meets_criteria = 0
  while starting <= ending:
    let test = $starting
    let pass_as_seq: seq[char] = toSeq(test.items)
    let never_decreases = check_never_decreases(pass_as_seq)
    if never_decreases == true:
      let check_adjacent = check_adjacent_and_the_same(pass_as_seq)
      if check_adjacent:
        meets_criteria += 1
    starting += 1
  meets_criteria

proc day_four_part_two*(starting, ending: int): int =
  ## Same as above except the adjacent digits can only be repeated once.
  ##
  ## Example:
  ##
  ## This is valid:  `111122`
  ## This is not: `123444`
  var starting = starting
  var meets_criteria = 0
  while starting <= ending:
    let test = $starting
    let pass_as_seq: seq[char] = toSeq(test.items)
    let never_decreases = check_never_decreases(pass_as_seq)
    if never_decreases == true:
      let check_adjacent = check_that_adjacent_is_only_a_pair(pass_as_seq)
      if check_adjacent == true:
        meets_criteria += 1
    starting += 1
  meets_criteria

when isMainModule:
  echo day_four_part_two(156218, 652527)