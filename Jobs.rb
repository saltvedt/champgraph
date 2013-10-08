require_relative 'Scraper'
require_relative 'Champion'
require_relative 'Graph'

require 'csv'

class Jobs

	def self.get_champions(url)
		puts "Scraping URL #{url}"
		s = Scraper.new(url)

		champions = s.scrape_champions

		champions.keep_if { |c| c.valid }

		champions.keep_if { |c| c.were_picked_or_banned }

		return champions
	end

	def self.get_most_used_champion(champions)
		most_used = Champion.new(nil, 0, 0, 0, 0)
		champions.each { |c| 
			if most_used.picks_and_bans < c.picks_and_bans
				most_used = c
			end
		}
		return most_used
	end

	def self.write_graphs(name, champions)
		title = "#{name}: Ordered by picks and bans"
		puts "Drawing " + title
		champions.sort! { |a, b| b.picks_and_bans <=> a.picks_and_bans }
		@graph.draw(champions, "by_picks_and_bans", title)

		title = "#{name}: Ordered by picks"
		puts "Drawing " + title
		champions.sort! { |a, b| b.picks <=> a.picks }
		@graph.draw(champions, "by_picks", title)

		title = "#{name}: Ordered by wins"
		puts "Drawing " + title
		champions.sort! { |a, b| b.wins <=> a.wins }
		@graph.draw(champions, "by_wins", title)

		title = "#{name}: Ordered by losses"
		puts "Drawing " + title
		champions.sort! { |a, b| b.losses <=> a.losses }
		@graph.draw(champions, "by_losses", title)

		#title = "#{name}: Ordered by picks and bans"
		#puts "Drawing " + title
		#champions.sort! { |a, b| b.win_to_loss_ratio <=> a.win_to_loss_ratio }
		#@graph.draw(champions, "ByWinToLossRatio", title)

		champions.keep_if { |c| c.were_banned }

		title = "#{name}: Ordered by bans"
		puts "Drawing " + title
		champions.sort! { |a, b| b.bans <=> a.bans }
		@graph.draw(champions, "by_bans", title)

		#title = "#{name}: By picks and bans"
		#puts "Drawing " + title
		#champions.sort! { |a, b| b.picks_to_bans_ratio <=> a.picks_to_bans_ratio }
		#@graph.draw(champions, "ByPicksToBansRatio", title)
	end

	def self.merge_champion_stats(champions)
		new_champ_stats = []

		champion_names = champions.map do |c|
			c.name
		end

		champion_names.uniq!

		champion_names.each do |name|
			champion_stats = champions.select { |c| c.name == name }

			picks = 0
			champion_stats.each { |c| picks += c.picks }

			wins = 0
			champion_stats.each { |c| wins += c.wins }

			losses = 0
			champion_stats.each { |c| losses += c.losses }

			bans = 0
			champion_stats.each { |c| bans += c.bans }

			new_champ_stats += [Champion.new(name, bans, picks, wins, losses)]
		end

		return new_champ_stats
	end

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

	def self.scrape_jobs
		Jobs.jobs.each do |key, job|
			all_champion_stats = []

			job[:urls].each do |url|
				champions = Jobs.get_champions(url)
				all_champion_stats += champions
			end

			champion_stats = Jobs.merge_champion_stats(all_champion_stats)

			# Save job data in csv
			if !File.directory?("data/" + key.to_s) 
				Dir.mkdir("data/" + key.to_s, 0755)
			end

			CSV.open("data/" + key.to_s + "/data.csv", "wb") do |csv|
				champion_stats.each do |c|
					csv << c.to_a
				end
			end
		end
	end

	def self.draw_jobs
		Jobs.jobs.each do |key, job|
			
			# Note, we're not checking if the file actually exists but probably should
			champion_stats = []
			CSV.foreach("data/" + key.to_s + "/data.csv", "r") do |row|
				champion_stats += [Champion.new(row[0],row[1],row[2],row[3],row[4])]
			end

			puts champion_stats

			most_used = Jobs.get_most_used_champion(champion_stats)

			graph_width = most_used.picks_and_bans

			@graph = Graph.new(job[:name], job[:urls][0], graph_width, key.to_s)

			Jobs.write_graphs(job[:name], champion_stats)
		end
	end
end