class MerakiTooPlayer < Player

 QUEUE = [ :rock,
           :paper,
           :scissors ]

 BEAT = { :rock => :paper, :paper => :scissors, :scissors => :rock }


 def initialize( opponent )
   super
   @runs = 0
   @opponent = opponent
   @index = 0
   @wins = 0
   @draws = 0

   @results = { :paper => 0, :rock => 0, :scissors => 0 }
   end

 def choose
   if @runs < 100
     choice = QUEUE[@index]

     @index += 1
     @index = 0 if @index == QUEUE.size

     choice
   elsif @runs < 200
     QUEUE[rand(10000000000000) % 3]
   else
     if @results[:rock] > @results[:paper] && @results[:rock] >
@results[:scissors]
       them = :rock
     elsif @results[:paper] > @results[:rock] && @results[:paper] >
@results[:scissors]
       them = :paper
     else
       them = :scissors
     end

     BEAT[them]
   end
 end

 def result( you, them, win_lose_or_draw )
   @runs += 1
   @results[them] += 1
   @wins += 1 if win_lose_or_draw == :win
   @draws += 1 if win_lose_or_draw == :draw

   # optional
   #
   # called after each choice you make to give feedback
   # you              = your choice
   # them             = opponent's choice
   # win_lose_or_draw = :win, :lose or :draw, your result
 end
end