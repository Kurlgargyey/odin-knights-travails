# frozen_string_literal: true

require 'matrix'

# The Node class has the square it represents, potential destination squares and a history of previous moves.
class Node
  attr_accessor :children
  attr_reader :history, :square

  def initialize(square = [0, 0], history = [])
    @square = Vector.elements(square.to_a)
    @children = []
    @history = []
    @history.concat(history)
    @history << @square
  end

  def to_s
    "Node: #{square}\nHistory: #{history}"
  end

  def to_a
    @square.to_a
  end
end

# The Board class has a simple array of all legal squares
class Board
  attr_reader :squares

  def initialize(dimensions = 8)
    @squares = []

    dimensions.times do |i1|
      dimensions.times do |i2|
        @squares << Vector[i1, i2]
      end
    end
  end
end

# The Knight class has a board and an array of legal movement vectors.
# Its #moves method traverses a tree of potential moves in breadth-first order using the given starting square as root.
class Knight
  def initialize
    @board = Board.new
    @movement = []
    @movement.concat([1, -1].product([2, -2]))
    @movement.concat([2, -2].product([1, -1]))
    @movement.map! { |move| Vector.elements(move) }
  end

  def moves(start, goal)
    start = Node.new(start)
    goal = Vector.elements(goal)
    result = search_move_tree(goal, start)
    puts "\nRoute found!"
    puts "We travelled from #{start.to_a} to #{goal.to_a}."
    puts "The journey took #{result.length - 1} moves."
    puts 'We visited the following squares:'
    result.each { |step| puts step.to_s }
    print "\n"
  end

  private

  def search_move_tree(goal, node)
    queue = [node]
    curr = node

    until curr.square == goal
      curr = queue.shift
      add_children(curr)
      curr.children.each do |child|
        queue << child
      end
    end
    curr.history.map(&:to_a)
  end

  def add_children(node)
    children = @movement.map { |move| move + node.square }.intersection(@board.squares)
    # children.reject! { |child| child.to_a.any? { |coord| coord.negative? || coord > 7 } }
    children.each { |child| node.children << Node.new(child, node.history) }
  end
end
