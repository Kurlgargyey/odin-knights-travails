# frozen_string_literal: true

require './lib/knights_travails.rb'

knight = Knight.new

start = [3, 3]
goal = [0, 0]

knight.moves(start, goal)