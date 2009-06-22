#!/usr/bin/env ruby

# Brackets:

TEAMS = ['Oof', 'Foo', 'Meraki', 'Spill Beer', 'Desperadoes', 'SIS']

order = (0..TEAMS.length-1).to_a.sort_by {rand}

order.each_with_index do |i, index|
  puts "Team: #{TEAMS[i]}, Position: #{index + 1}"
end
