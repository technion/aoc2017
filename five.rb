#!/usr/bin/env ruby

def solvefive(maze)
  offset = 0
  moves = 0

  while(offset >= 0 && offset < maze.length) do
    oldoffset = maze[offset]
    maze[offset] += oldoffset >= 3 ? - 1 :  1
    offset = offset + oldoffset
    moves = moves + 1
  end
  moves
end


example = [0, 3, 0, 1, -3]

puts solvefive(example)

maze = File.read("five.txt").split("\n").map(&:to_i)
puts solvefive(maze)

