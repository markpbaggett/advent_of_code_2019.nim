import streams, strutils, math

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
