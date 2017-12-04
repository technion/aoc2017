#!/usr/bin/env ruby

require 'set'

combinations = 0

testlines = File.read("four.txt")
testlines.lines.each do |aline|
  words = aline.split(" ")
  #Comment out to solve set one only
  words = words.map { |n| n.chars.sort.join }
  aset = Set.new words
  combinations = combinations + 1 if words.length == aset.length
end

puts combinations
