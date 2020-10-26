# frozen_string_literal: true
require "./classes/match"

RSpec.describe(Match) do
  describe '#initialize' do
    context "with a valid match result" do
      let(:match_result) { "Montrose Magpies 5, Appleby Arrows 0\n" }
      before(:each) do
        @match_instance = described_class.new(match_result)
      end
      it "sets the instance variable for team one" do
        expect(@match_instance.instance_variable_get(:@team1)).to(eql("Montrose Magpies"))
      end
      it "sets the instance variable for team one score" do
        expect(@match_instance.instance_variable_get(:@score1)).to(eql("5"))
      end
      it "sets the instance variable for team two" do
        expect(@match_instance.instance_variable_get(:@team2)).to(eql("Appleby Arrows"))
      end
      it "sets the instance variable for team two score" do
        expect(@match_instance.instance_variable_get(:@score2)).to(eql("0"))
      end
    end
    context "with invalid match result" do
      it "raises an exception if the same team is listed for both teams" do
        match_result = "Montrose Magpies 5, Montrose Magpies 0\n"
        expect { described_class.new(match_result) }.to(raise_error(Match::Error, "Invalid match"))
      end
      it "raises an exception if a score is negative" do
        match_result = "Montrose Magpies -1, Not Montrose Magpies 2\n"
        expect { described_class.new(match_result) }.to(raise_error(Match::Error, "Invalid score"))
      end
      it "raises an exception if a score is missing" do
        match_result = "Montrose Magpies 1\n"
        expect { described_class.new(match_result) }.to(raise_error(Match::Error, "Missing score"))
      end
    end
  end
  describe '#league_points' do
    context "team one winning" do
      let(:match_result) { "Montrose Magpies 5, Appleby Arrows 0\n" }
      it "returns team 1 name with 3 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "Montrose Magpies" => 3 }))
      end
      it "returns team 2 name with 0 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "Appleby Arrows" => 0 }))
      end
    end
    context "team two winning" do
      let(:match_result) { "The Holyhead Harpies 0, The Wimbourne Wasps 1\n" }
      it "returns team 2 name with 3 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "The Wimbourne Wasps" => 3 }))
      end
      it "returns team 1 name with 0 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "The Holyhead Harpies" => 0 }))
      end
    end
    context "with a draw" do
      let(:match_result) { "The Ballycastle Bats 1, The Wimbourne Wasps 1" }
      it "returns team 1 name with 1 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "The Ballycastle Bats" => 1 }))
      end
      it "returns team 2 name with 1 points" do
        result = described_class.new(match_result).league_points
        expect(result).to(include({ "The Wimbourne Wasps" => 1 }))
      end
    end
  end
end
