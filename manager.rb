#!/usr/bin/env ruby
require './team'

class Manager
  attr_reader :team

  def initialize
  end

  def pick_a_team(squad, defense, mid, attack)
    @team = Team.new
    @squad = squad
    num_position = { goalkeeper: 1, defender: defense, midfielder: mid, attacker: attack}

    total_players = 0
    num_position.each {|position, num| total_players += num.to_i}
    print total_players
    raise "\n-------Illegal formation-------> You have"unless total_players == 11


    num_position.each do |position, num|
      pick_best_in_position(position, num)
    end

    if @team.players.count == 11
      @team.players.each {|player| puts player}
    else
      puts "\n\n Sorry - your team must be GK + 10 players"
      return
    end

  end

  def pick_best_in_position(position, num)
    num.times do |i|
      @team << @squad.best_player(position)
    end
  end
end
