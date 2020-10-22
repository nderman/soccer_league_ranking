# frozen_string_literal: true
# attributes, team1, team2, score1, score2
# validation - score returned correctly
# teams can't be same
# scores must be valid (not negative or non integer)
class Match
  def initialize(team1:, score1:, team2:, score2:)
    @team1 = team1
    @score1 = score1
    @team2 = team2
    @score2 = score2
  end

  def league_points
  end
end
