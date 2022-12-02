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
        "X" => ROCK + DRAW,
        "Y" => PAPER + WIN,
        "Z" => SCISSORS + LOSE,
      },
      "B" => {
        "X" => ROCK + LOSE,
        "Y" => PAPER + DRAW,
        "Z" => SCISSORS + WIN,
      },
      "C" => {
        "X" => ROCK + WIN,
        "Y" => PAPER + LOSE,
        "Z" => SCISSORS + DRAW,
      },
    }

    def initialize(cheat_sheet_path)
      @cheat_sheet_path = cheat_sheet_path
      @scores = []
    end

    def evaluate
      File.foreach(@cheat_sheet_path) { |round|
        opponent_choice, player_choice = round.split
        score = POINTS_OUTCOME_MATRIX[opponent_choice][player_choice]
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
