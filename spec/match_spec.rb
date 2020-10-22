# frozen_string_literal: true
require "./classes/match"

RSpec.describe(Match) do
  describe '#initialize' do
    context "with valid values provided" do
      let(:match_values) { { team1: 'Montrose Magpies', score1: 5, team2: 'Appleby Arrows', score2: 0 } }
      before(:each) do
        @match_instance = described_class.new(**match_values)
      end
      it "sets the instance variable for team one" do
        expect(@match_instance.instance_variable_get(:@team1)).to(eql(match_values[:team1]))
      end
      it "sets the instance variable for team one score" do
        expect(@match_instance.instance_variable_get(:@score1)).to(eql(match_values[:score1]))
      end
      it "sets the instance variable for team two" do
        expect(@match_instance.instance_variable_get(:@team2)).to(eql(match_values[:team2]))
      end
      it "sets the instance variable for team two score" do
        expect(@match_instance.instance_variable_get(:@score2)).to(eql(match_values[:score2]))
      end
    end
  end
  describe '#league_points' do
    context "team one winning" do
      let(:match_values) { { team1: 'Montrose Magpies', score1: 5, team2: 'Appleby Arrows', score2: 0 } }
      it "returns team 1 name with 3 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team1], pts: 3 }))
      end
      it "returns team 2 name with 0 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team2], pts: 0 }))
      end
    end
    context "team two winning" do
      let(:match_values) { { team1: 'The Holyhead Harpies', score1: 0, team2: 'The Wimbourne Wasps', score2: 1 } }
      it "returns team 2 name with 3 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team2], pts: 3 }))
      end
      it "returns team 1 name with 0 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team1], pts: 0 }))
      end
    end
    context "with a draw" do
      let(:match_values) { { team1: 'The Ballycastle Bats', score1: 1, team2: 'The Wimbourne Wasps', score2: 1 } }
      it "returns team 1 name with 1 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team1], pts: 1 }))
      end
      it "returns team 2 name with 1 points" do
        result = described_class.new(**match_values).league_points
        expect(result).to(include({ team: match_values[:team2], pts: 1 }))
      end
    end
  end
end
