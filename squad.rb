#!/usr/bin/env ruby
require './coach_and_player'

class Coach

  def calculate_form(player)
    uninjured_form = player.skill * (rand(10) +1)
    player.form =  player.injured ? 0 :(uninjured_form*1)
  end
end

class Squad

  attr_reader :players

  def initialize
    @players = []
    @coach = Coach.new
  end

  def <<(player)
    @coach.calculate_form(player)
    @players << player
  end

  def best_player(position)

    player = @players.select{|p| p.position == position && p.injured == false}.sort{|a,b| a.form <=> b.form}.last

    raise "\n\n----Not enough players in that position----\n\n" if player.nil?

    # if player.nil?
    #   raise "Not enough players in that position"
    #   break
    # end

    @players.delete_if {|x| x == player}     # remove the player from @players
    # what if player.nil? maybe raise an exception
    if player.nil?
      puts "Not enough players, maybe try changing formation"
    else
      player
    end
  end

end
