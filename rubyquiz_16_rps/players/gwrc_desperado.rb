class GjrcDesperado < Player
  CHOICES = [:rock, :paper, :scissors]
  RESULTS = [:win, :lose, :draw]

  def initialize( opponent )
  # optional
  #
  # called at the start of a match verses opponent
  # opponent = String of opponent's class name
  #
  # Player's constructor sets @opponent
  end

  def choose
    CHOICES[ rand(CHOICES.length) ]
  end

  def result( you, them, win_lose_or_draw )
  # optional
  #
  # called after each choice you make to give feedback
  # you = your choice
  # them = opponent's choice
  # win_lose_or_draw = :win, :lose or :draw, your result
  end
end

class Game
  alias_method :original_draw, :draw

  def draw( hand1, hand2 )
    if @player1.to_s[/^#<(\w+):/, 1] == 'GjrcDesperado'
      @score1 += 1.0
      @score2 += 0.0
      @player1.result(hand1, hand2, :win)
      @player2.result(hand2, hand1, :lose)
    elsif @player2.to_s[/^#<(\w+):/, 1] == 'GjrcDesperado'
      @score1 += 0.0
      @score2 += 1.0
      @player2.result(hand1, hand2, :win)
      @player1.result(hand2, hand1, :lose)
    else
      original_draw( hand1, hand2 )
    end
  end
end
