module RockPaperScissors
  class CheatSheetCalculator
    ROCK = 1
    PAPER = 2
    SCISSORS = 3

    WIN = 6
    DRAW = 3
    LOSE = 0

    POINTS_OUTCOME_MATRIX = {
      "A" => {
        "X" => SCISSORS + LOSE,
        "Y" => ROCK + DRAW,
        "Z" => PAPER + WIN,
      },
      "B" => {
        "X" => ROCK + LOSE,
        "Y" => PAPER + DRAW,
        "Z" => SCISSORS + WIN,
      },
      "C" => {
        "X" => PAPER + LOSE,
        "Y" => SCISSORS + DRAW,
        "Z" => ROCK + WIN,
      },
    }

    def initialize(cheat_sheet_path)
      @cheat_sheet_path = cheat_sheet_path
      @scores = []
    end

    def evaluate
      File.foreach(@cheat_sheet_path) { |round|
        opponent_choice, desired_outcome = round.split
        score = POINTS_OUTCOME_MATRIX[opponent_choice][desired_outcome]
        @scores << score
      }
    end

    def announce
      puts total_score
    end

    def total_score
      @scores.sum
    end
  end
end

cheat_sheet_calc = RockPaperScissors::CheatSheetCalculator.new(ARGV[0])
cheat_sheet_calc.evaluate
cheat_sheet_calc.announce
