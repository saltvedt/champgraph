class Jobs
	def self.to_select_html
		puts "<select>"
		jobs.each { |key, job|
			puts "<option value=\"#{key}\">#{job[:name]}</option>"
		}
		puts "</select>"
	end


	def self.jobs
		eu_lcs_spring_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Season"]

		eu_lcs_spring_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Playoffs"]

		eu_lcs_summer_promotion = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Promotion"]

		eu_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Season"]

		eu_lcs_summer_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Playoffs"]

		eu_lcs = eu_lcs_spring_season + eu_lcs_spring_playoffs + eu_lcs_summer_promotion + eu_lcs_summer_season + eu_lcs_summer_playoffs

		na_lcs_spring_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Spring_Season"]

		na_lcs_spring_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Spring_Playoffs"]

		na_lcs_summer_promotion = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Promotion"]

		na_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Season"]

		na_lcs_summer_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Playoffs"]

		na_lcs = na_lcs_spring_season + na_lcs_spring_playoffs + na_lcs_summer_promotion + na_lcs_summer_season + na_lcs_summer_playoffs

		lcs = eu_lcs + na_lcs
		
		{
			# EU
			:eu_lcs_spring_season => {
				:name => "EU LCS Spring Season",
				:urls => eu_lcs_spring_season
			},
			:eu_lcs_spring_playoffs => {
				:name => "EU LCS Spring Playoffs",
				:urls => eu_lcs_spring_playoffs
			},
			:eu_lcs_summer_promotion => {
				:name => "EU LCS Summer Promotion",
				:urls => eu_lcs_summer_promotion
			},
			:eu_lcs_summer_season => {
				:name => "EU LCS Summer Season",
				:urls => eu_lcs_summer_season
			},
			:eu_lcs_summer_playoffs => {
				:name => "EU LCS Summer Playoffs",
				:urls => eu_lcs_summer_playoffs
			},
			:eu_lcs => {
				:name => "EU LCS All Games",
				:urls => eu_lcs
			},
			# NA
			:na_lcs_spring_season => {
				:name => "NA LCS Spring Season",
				:urls => na_lcs_spring_season
			},
			:na_lcs_spring_playoffs => {
				:name => "NA LCS Spring Playoffs",
				:urls => na_lcs_spring_playoffs
			},
			:na_lcs_summer_promotion => {
				:name => "NA LCS Summer Promotion",
				:urls => na_lcs_summer_promotion
			},
			:na_lcs_summer_season => {
				:name => "NA LCS Summer Season",
				:urls => na_lcs_summer_season
			},
			:na_lcs_summer_playoffs => {
				:name => "NA LCS Summer Playoffs",
				:urls => na_lcs_summer_playoffs
			},
			:na_lcs => {
				:name => "NA LCS All Games",
				:urls => na_lcs
			},
			# ALL
			:lcs => {
				:name => "All LCS Games (NA and EU combined)",
				:urls => lcs
			}
		}
	end
end