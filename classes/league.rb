# frozen_string_literal: true
require './classes/match.rb'
class League
  class Error < StandardError; end

  def points(source = 'input.txt', target = "output.txt")
    begin
      league_points = read_input(source)
      league_table = process_league(league_points)
      write_output(league_table, target)
    rescue League::Error => exception
      return (exception.message)
    end

    "Successfully created #{target}"
  end

  private

  def read_input(source)
    league_points = []

    File.open(source) do |file|
      file.each_line.with_index do |line, index|
        league_points += Match.new(line).league_points
      rescue Match::Error => exception
        raise Error, "Match file error on line #{index + 1} - #{exception.message}"
      end
    end
    league_points
  end

  def process_league(league_points)
    # merge and add league points by team name and then sort by score then name
    league_points.reduce { |acc, h| acc.merge(h) { |_k, v1, v2| v1 + v2 } }
      .sort_by { |k, v| [-v, k] }.to_h
  end

  def write_output(league_table, target)
    File.open(target, 'w') do |f|
      league_table.each_with_index do |(key, value), index|
        f.puts "#{index + 1}. #{key}, #{value} #{value == 1 ? 'pt' : 'pts'}"
      end
    end
  end
end
