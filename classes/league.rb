# frozen_string_literal: true
require './classes/match.rb'
class League
  def points(source = 'input.txt', target = "output.txt")
    league_points = []

    File.open(source) do |file|
      file.each_line do |line|
        league_points += Match.new(line).league_points
      end
    end
    # merge and add league points by team name and then sort by score then name
    league_points = league_points.reduce { |acc, h| acc.merge(h) { |_k, v1, v2| v1 + v2 } }
      .sort_by { |k, v| [-v, k] }.to_h

    File.open(target, 'w') do |f|
      league_points.each_with_index do |(key, value), index|
        f.puts "#{index + 1}. #{key}, #{value} #{value == 1 ? 'pt' : 'pts'}"
      end
    end
  end
end
