class Jobs
	def self.jobs
		eu_lcs_spring_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Season"]

		eu_lcs_spring_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Season"]

		eu_lcs_spring_promotion = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Promotion"]

		eu_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Season"]

		eu_lcs_summer_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Playoffs"]

		eu_lcs = eu_lcs_spring_season + eu_lcs_spring_playoffs + eu_lcs_spring_promotion + eu_lcs_summer_season + eu_lcs_summer_playoffs

		na_lcs_spring_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Spring_Season"]

		na_lcs_spring_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Spring_Playoffs"]

		na_lcs_spring_promotion = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Promotion"]

		na_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Season"]

		#na_lcs_summer_playoffs = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Playoffs"]

		na_lcs = na_lcs_spring_season + na_lcs_spring_playoffs + na_lcs_spring_promotion + na_lcs_summer_season #+ na_lcs_summer_playoffs

		lcs = eu_lcs + na_lcs
		
		{
			:eu_lcs => {
				:name 		=> "EU LCS summer season",
				:short_name => "eu_lcs_summer_season",
				:urls 		=> eu_lcs
			},
			:na_lcs => {
				:name 		=> "NA LCS summer season",
				:short_name => "na_lcs_summer_season",
				:urls 		=> na_lcs
			},
			:lcs => {
				:name 		=> "LCS",
				:short_name => "lcs",
				:urls		=> lcs
			}
		}
	end
end