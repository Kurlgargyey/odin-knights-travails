# frozen_string_literal: true

class Square
  attr_accessor :coords

  def initialize(col, row)
    @coords = [col, row]
  end

  def ==(other)
    @coords[0] == other.coords[0] &&
      @coords[1] == other.coords[1]
  end
end

class Node
  attr_accessor :square, :children

  def initialize(square = nil)
    @square = square
    @children = []
    @children << children
  end

  private

  def child(square, movecoords)
    Square.new(square.coords[0] + movecoords[0], square.coords[1] + movecoords[1])
  end

end

class Board
  attr_accessor :squares

  def initialize(dimensions = 8)
    @squares = []

    dimensions.times do |i1|
      dimensions.times do |i2|
        @squares << Square.new(i1, i2)
      end
    end
  end
end

class Knight

  def initialize
    @board = Board.new
    @root = build_tree
  end

  def knight_moves

  end

  private

  def build_tree
    node = Node.new(data)

    if root.nil?
      @root = node
      return
    end

    root.children.each do |child|

    end
  end
end

