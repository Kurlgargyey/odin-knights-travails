# frozen_string_literal: true

require 'matrix'

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
end

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

class Knight
  def initialize
    @board = Board.new
    @movement = []
    @movement.concat([1, -1].product([2, -2]))
    @movement.concat([2, -2].product([1, -1]))
    @movement.map! { |move| Vector.elements(move) }
  end

  def moves(start, target)
    start = Node.new(start)
    target = Vector.elements(target)
    result = search_move_tree(target, start)
    puts "\nRoute found!"
    puts "The journey took #{result.history.length - 1} moves."
    puts 'We visited the following squares:'
    result.history.each do |step|
      print "#{step.to_a} "
      print "\n"
    end
    print "\n"
  end

  private

  def search_move_tree(target, node)
    queue = [node]
    curr = node

    until curr.square == target
      curr = queue.shift
      add_children(curr)
      curr.children.each do |child|
        queue << child
      end
    end
    curr
  end

  def add_children(node)
    children = @movement.map { |move| move + node.square }
    children.reject! { |child| child.to_a.any? { |coord| coord.negative? || coord > 7 } }
    children.each { |child| node.children << Node.new(child, node.history) }
  end
end
