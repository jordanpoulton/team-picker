#!/usr/bin/env ruby
class Player

  attr_accessor :form
  attr_reader :skill, :position, :injured

  def initialize(name, position, skill, injured)
    @name, @position, @skill, @injured = name, position, skill, injured
  end

  def eligible?
    return false if self.injured = true
    return true if self.injured = false
  end

  def to_s
  #player_array = [@name, @position, @skill, @injured]
    if self.injured
      "\n
      #{@name} - My form is: #{@form}, on Skill #{@skill}. --(I'm Injured)
      \n"
    else
      "\n
      #{@name} - My form is: #{@form}, on Skill #{@skill}.\n"
    end
  end
end

