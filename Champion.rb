class Champion
    attr_reader :name, :bans, :picks, :wins, :losses

    def initialize(name, bans, picks, wins, losses)
        @name = name
        @bans = bans.to_i
        @picks = picks.to_i
        @wins = wins.to_i
        @losses = losses.to_i
    end

    # Add anothers champions stats to this one
    def add(champion)
        if @name = champion.name
            @bans   += champion.bans
            @picks  += champion.picks
            @wins   += champion.wins
            @losses += champion.losses
        end
    end

    def picks_and_bans
        @picks + @bans
    end

    def win_to_loss_ratio
        Champion::ratio(@wins, @losses)
    end

    def picks_to_bans_ratio
        Champion::ratio(@picks, @bans)
    end

    def valid
        @name != "" && @name != nil
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

    def to_a
        [@name, @bans.to_s, @picks.to_s, @wins.to_s, @losses.to_s]
    end

    # Ugly hack to avoid division by zero
    def self.ratio(x, y)
        x = x.to_f
        y = y.to_f

        if (x == 0) and (y == 0) then
            return 0.to_f
        end

        if (y == 0) then
            return (x+1000).to_f
        end

        if x == 0 then
            return (0-y).to_f
        end

        return (x/y).to_f
    end
end
