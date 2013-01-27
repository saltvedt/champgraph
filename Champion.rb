class Champion
	
	attr_reader :name, :bans, :picks, :wins, :losses 

	def initialize(name, bans, picks, wins, losses)
		@name = name
		@bans = bans
		@picks = picks
		@wins = wins
		@losses = losses
	end

	def picks_and_bans
		@picks + @bans
	end

	def win_to_loss_ratio
		ratio(@wins, @losses)
	end

	def picks_to_bans_ratio
		ratio(@picks, @bans)
	end

	def valid
		@name != ""
	end

	def were_picked_or_banned
		@picks + @bans > 0
	end

	def were_banned
		@bans > 0
	end

	def to_s
		sep = " - "
		@name + sep + @bans.to_s + sep + @picks.to_s + sep + @wins.to_s + sep + @losses.to_s
	end

	private

	# Ugly hack to avoid division by zero
	def ratio(x, y)
		if y == 0
			return x+1000
		end

		if x == 0
			return y-1000
		end

		return x/y
	end
end
