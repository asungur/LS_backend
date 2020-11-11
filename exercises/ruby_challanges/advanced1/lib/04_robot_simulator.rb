class Robot
  attr_reader :bearing, :coordinates
  
  DIRECTIONS = [:north, :east, :south, :west].freeze
  ADVANCE = {
    north: [0, 1],
    east:  [1, 0],
    south: [0, -1],
    west:  [-1, 0]
  }.freeze

  def initialize

  end

  def orient(direction)
    if Robot::DIRECTIONS.include?(direction)
      @bearing = direction
    else
      raise ArgumentError.new("Invalid direction provided")
    end
  end

  def turn_right
    turn(:right)
  end

  def turn_left
    turn(:left)
  end

  def at(x_coord, y_coord)
    @coordinates = [x_coord, y_coord]
  end

  def advance
    move_vector = Robot::ADVANCE[@bearing]
    new_x = coordinates[0] + move_vector[0]
    new_y = coordinates[1] + move_vector[1]

    @coordinates = [new_x, new_y]
  end

  private

  def turn(towards = :right)
    direction = towards == :right ? 1 : -1

    initial_direction = Robot::DIRECTIONS.index(@bearing)
    new_direction = (initial_direction + direction) % Robot::DIRECTIONS.length
    @bearing = Robot::DIRECTIONS[new_direction]
  end
end

class Simulator
  COMMANDS = {
    "R" => :turn_right,
    "L" => :turn_left,
    "A" => :advance
  }.freeze
  
  def initialize
  end

  def instructions(directive_str)
    command_arr = []

    directive_str.each_char { |c| command_arr << Simulator::COMMANDS[c] }

    command_arr
  end

  def place(robot, directives)
    robot.at(directives[:x], directives[:y])
    robot.orient(directives[:direction])
  end

  def evaluate(robot, directive_str)
    commands = instructions(directive_str)

    commands.each { |command| robot.send(command) }
  end
end
