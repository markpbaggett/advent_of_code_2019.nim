import streams, strutils, math, strformat

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

proc process_opcode_one(input: seq[int], value1, value2, value3: int): seq[int] =
  var list = input
  list[value3] = list[value1] + list[value2]
  list

proc process_opcode_two(input: seq[int], value1, value2, value3: int): seq[int] =
  var list = input
  list[value3] = list[value1] * list[value2]
  list

proc day_two_main_part_one*(input: seq[int]): int =
  var list = input
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

when isMainModule:
  var inputs = @[1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,19,5,23,1,13,23,27,1,27,6,31,2,31,6,35,2,6,35,39,1,39,5,43,1,13,43,47,1,6,47,51,2,13,51,55,1,10,55,59,1,59,5,63,1,10,63,67,1,67,5,71,1,71,10,75,1,9,75,79,2,13,79,83,1,9,83,87,2,87,13,91,1,10,91,95,1,95,9,99,1,13,99,103,2,103,13,107,1,107,10,111,2,10,111,115,1,115,9,119,2,119,6,123,1,5,123,127,1,5,127,131,1,10,131,135,1,135,6,139,1,10,139,143,1,143,6,147,2,147,13,151,1,5,151,155,1,155,5,159,1,159,2,163,1,163,9,0,99,2,14,0,0]
  inputs[1] = 12
  inputs[2] = 2
  echo day_two_main_part_one(inputs)