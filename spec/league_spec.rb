# frozen_string_literal: true
require "./classes/league"
require "./classes/match"
require 'tempfile'
RSpec.describe(League) do
  def input_file(matches)
    Tempfile.new('input').tap do |f|
      matches.each do |match|
        f.puts match
      end
      f.close
    end
  end

  describe '#points' do
    context "with a valid match results file" do
      let(:test_out_file) { Tempfile.new('output') }
      after do
        test_out_file.unlink
      end
      it 'calculates the correct league table' do
        matches = ["Lions 3, Snakes 3", "Tarantulas 1, FC Awesome 0", "Lions 1, FC Awesome 1"]
        test_in_file = input_file(matches)
        described_class.new.points(test_in_file.path, test_out_file.path)
        expect(File.open(test_out_file.path).readlines).to(eq(
          ["1. Tarantulas, 3 pts\n", "2. Lions, 2 pts\n", "3. FC Awesome, 1 pt\n", "4. Snakes, 1 pt\n"]
        ))
        test_in_file.unlink
      end
      it 'orders the league table from highest to lowest points' do
        matches = ["Lions 3, Snakes 3", "Tarantulas 1, FC Awesome 0", "Lions 1, FC Awesome 1", "Snakes 3, Grouches 1"]
        test_in_file = input_file(matches)
        described_class.new.points(test_in_file.path, test_out_file.path)
        expect(File.open(test_out_file.path).readlines).to(eq(
          ["1. Snakes, 4 pts\n", "2. Tarantulas, 3 pts\n",
           "3. Lions, 2 pts\n", "4. FC Awesome, 1 pt\n", "5. Grouches, 0 pts\n"]
        ))
        test_in_file.unlink
      end
      it 'orders the league table alphabetically for tied scores' do
        matches = ["Zebras 3, Artichokes 3", "Badgers 1, Capybraras 1", "Snakes 3, Grouches 3"]
        test_in_file = input_file(matches)
        described_class.new.points(test_in_file.path, test_out_file.path)
        expect(File.open(test_out_file.path).readlines).to(eq(
          ["1. Artichokes, 1 pt\n", "2. Badgers, 1 pt\n", "3. Capybraras, 1 pt\n",
           "4. Grouches, 1 pt\n", "5. Snakes, 1 pt\n", "6. Zebras, 1 pt\n"]
        ))
        test_in_file.unlink
      end
    end
    context "with an invalid match results file" do
      it "Returns the invalid line for a negative score" do
        matches = ["Zebras 3, Artichokes -1", "Badgers 1, Capybraras 1", "Snakes 3, Grouches 3"]
        test_in_file = input_file(matches)
        expect(described_class.new.points(test_in_file.path, "out.txt"))
          .to(eql("Match file error on line 1 - Invalid score"))
      end
      it "Returns the invalid line for an invalid match (same team)" do
        matches = ["Zebras 3, Artichokes 1", "Badgers 1, Badgers 1", "Snakes 3, Grouches 3"]
        test_in_file = input_file(matches)
        expect(described_class.new.points(test_in_file.path, "out.txt"))
          .to(eql("Match file error on line 2 - Invalid match"))
      end
      it "Returns the invalid line for an invalid score (missing score)" do
        matches = ["Zebras 3, Artichokes 1", "Badgers 1, Badgers", "Snakes 3, Grouches 3"]
        test_in_file = input_file(matches)
        expect(described_class.new.points(test_in_file.path, "out.txt"))
          .to(eql("Match file error on line 2 - Invalid score"))
      end
    end
  end
end
