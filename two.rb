#!/usr/bin/env ruby

def arraydiff(a)
  while test = a.pop
    a.each do |n|
      if n % test == 0
        return n / test
      end
      if test % n == 0
        return test / n
      end
    end 
  end
  raise "Did not find answer"
end

def checksum(array)
  sum = 0
  array.each do |n|
    sum = sum + arraydiff(n)
  end
  sum
end

raise "Check failed" unless (checksum([[5,9,2,8],[9,4,7,3],[3,8,6,5]]) == 9)
puts "Selftest passed"

testlines = File.read("two.txt")
    .split("\n")
    .map { |n| n.split("\t").map(&:to_i) }
puts "Answer found: #{ checksum(testlines) }"
