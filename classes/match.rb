# frozen_string_literal: true
# validation - score returned correctly
# teams can't be same
# scores must be valid (not negative or non integer)
class Match
  def initialize(match_result)
    match_result = match_result.strip.split(', ').map! do |item|
      item = item.rpartition(' ')
      [item.first, item.last]
    end
    match_result = match_result.flatten
    @team1 = match_result[0]
    @score1 = match_result[1]
    @team2 = match_result[2]
    @score2 = match_result[3]
  end

  def league_points
    team1_points = {}
    team2_points = {}
    if @score1 == @score2
      team1_points[@team1] = 1
      team2_points[@team2] = 1
    end
    if @score1 > @score2
      team1_points[@team1] = 3
      team2_points[@team2] = 0
    end
    if @score2 > @score1
      team1_points[@team2] = 3
      team2_points[@team1] = 0
    end
    [team1_points, team2_points]
  end
end
