class Jobs
	def self.jobs
		eu_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Summer_Season"]

		na_lcs_summer_season = ["http://lol.gamepedia.com/Riot_League_Championship_Series/North_America/Season_3/Picks_and_Bans/Summer_Season"]

		lcs = eu_lcs_summer_season + na_lcs_summer_season
		
		{
			:eu_lcs => {
				:name 		=> "EU LCS summer season",
				:short_name => "eu_lcs_summer_season",
				:urls 		=> eu_lcs_summer_season
			},
			:na_lcs => {
				:name 		=> "NA LCS summer season",
				:short_name => "na_lcs_summer_season",
				:urls 		=> na_lcs_summer_season
			},
			:lcs => {
				:name 		=> "LCS",
				:short_name => "lcs",
				:urls		=> lcs
			}
		}
	end
end