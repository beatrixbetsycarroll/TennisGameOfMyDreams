class Player
  attr_reader :id

  def initialize(args)
    @id = args[:id]
  end

  def hit
    rand(0..269)
  end

end

class Match
  attr_accessor :court, :last_player, :ball_position, :player1, :player2, :zero_or_one, :current_player
  attr_reader :blank_court

  def initialize(args)
    @blank_court = "_"*20 +
          ("|" + " "*18 + "|")*4 +
          ("|" + " "*4 + "|" + " "*8 + "|" + " "*4 + "|")*8 +
          ("|" + " "*4 + "|" + "_"*8 + "|" + " "*4 + "|") +
          ("|" + " "*4 + "|" + " "*8 + "|" + " "*4 + "|")*8 +
          ("|" + " "*18 + "|")*4 +
          "_"*20
    @court = @blank_court
    @player1 = args[:player1]
    @player2 = args[:player2]
    @current_player = @player1
    # @winner = nil ## will need something like this once I get there.
  end

  def play_rally
    if @current_player.id == 1
      @current_player = @player2
    else
      @current_player = @player1
    end
    # not sure why, but the above code isn't working properly when I take out the @ symbols, So I am leaving them there for now. Would like to understand what is going on tho. Thanks!
    update_position
    print_court
  end

  def update_position
    ball_position = current_player.hit + ((current_player.id - 1) * 270)
    court[ball_position] = "o"
  end

  # def game_over?
  # end ## would need something like this once I get to having points, a game ending, etc. Maybe I would make a class for Score? And call it in the Match class.

  def print_court
    print "player 1's side"
    (0..court.length).each do |i|
      if i % 20 == 0
        print "\n"
        print court[i]
      else
        print court[i]
      end
    end
    print "\nplayer 1's side"
    court = reset_court
  end

  def reset_court
    blank_court
    #my court is not resetting to the blank court...not sure why. I want the ball to move on the court, aka disappear from where it last was when it reappears on the other side of the court after being hit. Before I had COURT as a constant and it was a string representation of the blank court, but that wasn't working so I tried this way, as an attr_reader of the Match class. I also had tried making a class Court and making the blank court be an instance variable that it initializes. But I am not sure if that makes more sense than this anyways.
  end

end

class Controller
  def self.play
    View.greeting
    match = Match.new({player1: Player.new(id: 1), player2: Player.new(id: 2)})

    n = 0
    until n == 10
      View.clear_screen
      match.play_rally
      sleep(0.5)
      n+=1
    end
    # ideall this would be more like:
    # until there is a winner,
    # keep calling play_rally and printing the court out
    # end
  end
end


class View
  class << self
    def greeting
      print "welcome to the tennis game from my dream from last night."
    end

    def clear_screen
      puts "\e[H\e[2J"
    end
  end
# #plan for View class:
# #greeting
# #continuously print the reset court
# #clear
# #print the score

end

controller = Controller.new
Controller.play

