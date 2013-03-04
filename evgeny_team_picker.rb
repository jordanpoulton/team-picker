#!/usr/bin/env ruby
require 'action_view'

class Manager

  def self.pick_team(squad)
    team = Team.new(Team::FOUR_FOUR_TWO)
    team.formation.each do |position, count|
      team.recruit squad.top(position, count)      
    end
    team
  end

end

class Coach

  def self.form_for(player)    
    player.injured? ? 0 : (player.skill * rand).round
  end
  
end

class Player

  attr_accessor :form, :position, :skill

  include ActionView::Helpers::TextHelper # module

  def initialize(name, position, skill, injured)
    @name, @position, @skill, @injured = name, position, skill, injured
    @form = Coach.form_for(self)
  end

  def injured?
    @injured
  end

  def to_s
    # "#{@name.capitalize}: skill #{@skill}, form #{@form} #{(" (injured)" if injured?)}"
    "%12s: skill %2d, form %2d %s" % [@name.capitalize, @skill, @form, (" (injured)" if injured?)]
  end

  def <=>(another)
    self.form <=> another.form
  end


end

class Team

  FOUR_FOUR_TWO = {:goalkeeper => 1, :attacker => 2, :midfielder => 4, :defender => 4}
  FOUR_FIVE_ONE = {:goalkeeper => 1, :attacker => 1, :midfielder => 5, :defender => 4}

  attr_reader :formation

  def initialize(formation)
    @players, @formation = [], formation
  end

  def <<(player)  
    raise "Cannot add #{player} to the team" if no_position_for?(player)
    @players << player
  end

  def to_s
    @players.join("\n")
  end

  def recruit(new_players)
    new_players.each {|player| self << player }
  end

private

  def no_position_for?(player)
    @players.count{|p| p.position == player.position} >= @formation[player.position]
  end

end

class Squad

  include ActionView::Helpers::TextHelper

  FORMATION = {:goalkeeper => 2, :defender => 8, :midfielder => 8, :attacker => 8}  

  def initialize
    @players = []        
  end

  def <<(player)       
    @players << player
  end

  def top(position, count)
    # @players.reject {|p| p.injured? }
    eligible_players = @players.reject(&:injured?).select{|p| p.position == position}.sort
    if eligible_players.size < count
      raise "There are not enough #{position.to_s.pluralize} in the squad, need #{count}, got only #{eligible_players.size}"
    end        
    top_players = eligible_players.pop count
    @players.delete_if {|player| top_players.include? player}    
    top_players
  end

  def to_s    
    @players.join("\n")
  end

  def self.create!
    squad = self.new  # Squad.new
    FORMATION.each do |position, count|
      skill = rand(10) + 1
      injured = rand(5).zero?
      count.times {|i| squad << Player.new("#{position} #{i}", position, skill, injured)}
    end
    squad
  end


end

squad = Squad.create!
puts "Our squad:\n\n#{squad}\n\n"
team = Manager.pick_team(squad)
puts "Our chosen team:\n\n#{team}"



