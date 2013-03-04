class Team
  attr_reader :players

  def initialize
    @players = []
  end

  def <<(player)  # how to call it: team << player
    # raise an error if we can't add the player,
    # e.g. if we already have the position filled
    # raise "Can't add #{position}"
    @players << player
  end

  def to_s
    @players.to_s
  end
end
