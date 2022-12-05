class GamePlay

  OPPONENT_STRATEGY = {
    A: :rock,
    B: :paper,
    C: :scissor
  }

  MY_STRATEGY = {
    X: :rock,
    Y: :paper,
    Z: :scissor
  }

  RESULT = {
    X: :loose,
    Y: :draw,
    Z: :win
  }

  SCORE = {
    rock: 1,
    paper: 2,
    scissor: 3
  }

  attr_accessor :games, :score

  def initialize
    @games = []
    @score = 0
  end

  def process_score!
    read_lines_from_input_file
    # calculate_score
    calculate_score_when_result_known
    display_score
  end

  private

  def calculate_score
    self.score = games.map do |game_play|
      opponent_move = OPPONENT_STRATEGY[game_play[0].to_sym]
      my_move = MY_STRATEGY[game_play[2].to_sym]

      case [opponent_move, my_move]
        when [:rock, :paper], [:paper, :scissor], [:scissor, :rock]
          SCORE[my_move] + 6
        when [:rock, :scissor], [:paper, :rock], [:scissor, :paper]
          SCORE[my_move] + 0
        when [:rock, :rock], [:paper, :paper], [:scissor, :scissor]
          SCORE[my_move] + 3
      end
    end.inject(:+)
  end

  def calculate_score_when_result_known
    self.score = games.map do |game_play|
      opponent_move = OPPONENT_STRATEGY[game_play[0].to_sym]
      result = RESULT[game_play[2].to_sym]

      case result
        when :win
          SCORE[find_next_element(opponent_move)] + 6
        when :loose
          SCORE[find_previous_element(opponent_move)] + 0
        when :draw
          SCORE[opponent_move] + 3
      end
    end.inject(:+)
  end

  def find_next_element(element)
    SCORE.keys[SCORE.keys.index(element) + 1] || :rock
  end

  def find_previous_element(element)
    SCORE.keys[SCORE.keys.index(element) - 1] || :scissor
  end

  def display_score
    puts "SCORE: #{score}"
  end

  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.games = File.read(file_input).split(/\n/)
  end
end

calorie = GamePlay.new
calorie.process_score!

