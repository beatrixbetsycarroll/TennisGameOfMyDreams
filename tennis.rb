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
  attr_accessor :court, :last_player, :player_number, :ball_position, :player1, :player2, :zero_or_one, :player_array, :current_player
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
    @player_array = [@player1, @player2]
    @player_number = 0
    @winner = nil
    @current_player = @player1
  end

  def play_rally
    if @current_player.id == 1
      @current_player = @player2
    else
      @current_player = @player1
    end
    # call hit on whichever player was not last
    # call hit method from player class
    # which will return some rand index
    # put "o" at rand index on @court
    # check if there's a winner

    # last_player(@player_number)
    # update_position
    update_position
    print_court
  end

  def update_position
    ball_position = @current_player.hit + ((@current_player.id - 1) * 270)
    court[ball_position] = "o"
  end

  def game_over?
  end

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
    @blank_court
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

# #greeting
# #continuously print the reset court
# #clear
# #print the score


end

controller = Controller.new
Controller.play

