class Champion
	attr_accessor :name, :bans, :picks, :wins, :losses

	def initialize(name, bans, picks, wins, losses)
		@name = name
		@bans = bans
		@picks = picks
		@wins = wins
		@losses = losses
	end

	def to_s
		sep = " - "
		name + sep + bans.to_s + sep + picks.to_s + sep + wins.to_s + sep + losses.to_s
	end
end
