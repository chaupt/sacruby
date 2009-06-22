class SmartiePlayer < Player
  OPTIONS = [ :rock,
            :paper,
            :scissors ]

  def initialize( opponent )
    super
    @preferred_choice = nil
  end
  
  def choose
    if @preferred_choice
      @preferred_choice
    else
      OPTIONS[rand(OPTIONS.size)]      
    end
  end
  
  def result( you, them, win_lose_or_draw )
    @preferred_choice = nil
    if win_lose_or_draw == :win
      @preferred_choice = you
    elsif win_lose_or_draw == :lose
      case them
      when :rock
        @preferred_choice = :paper
      when :paper
        @preferred_choice = :scissors
      when :scissors
        @preferred_choice = :rock
      end
    else
      @preferred_choice = nil
    end
  end
end
