require 'rubygems'
require 'rvideo'

file = ARGV.shift

input = RVideo::Inspector.new :file => file

duration = input.raw_response[((input.raw_response =~ /Duration:/)+10),8]

temp = input.raw_response[input.raw_response =~ /Video:/,50]

puts temp

width, height = temp[(temp =~ /x/) - 3, 7].split('x')

puts duration
puts width
puts height
puts input.raw_response
