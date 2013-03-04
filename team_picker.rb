require './squad'
require './coach_and_player'
require './manager'
require './team'

def squad_with_players
  squad = Squad.new
  2.times do |i|
    squad << Player.new("Goalkeeper #{i}", :goalkeeper, rand(10) + 1, rand(5).zero?)
  end
  8.times do |i|
    squad << Player.new("Defender #{i}", :defender, rand(10) + 1, rand(5).zero?)
  end
  8.times do |i|
    squad << Player.new("Midfielder #{i}", :midfielder, rand(10) + 1, rand(5).zero?)
  end
  4.times do |i|
    squad << Player.new("Attacker #{i}", :attacker, rand(10) + 1, rand(5).zero?)
  end
  squad
end


first_squad = squad_with_players #assigns 22 players to the squad

first_squad.players.each {|player| puts player}

manager = Manager.new()
puts 'Choose a formation!

'
puts "Number of defenders?:"
user_defense = gets.chomp.to_i
puts "Number of midfielders?:"
user_midfielder = gets.chomp.to_i
puts "Number of attackers?:"
user_attackers = gets.chomp.to_i

user_team = manager.pick_a_team(first_squad, user_defense, user_midfielder, user_attackers)

#user_team = manager.pick_a_team(first_squad, 4, 4, 2)
