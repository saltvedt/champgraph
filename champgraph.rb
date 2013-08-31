require_relative 'Scraper'
require_relative 'Champion'
require_relative 'Graph'
require_relative 'Jobs'
require 'csv'

def get_champions(url)
	puts "Scraping URL"
	champions = @s.scrape_champions

	champions.keep_if { |c| c.valid }

	champions.keep_if { |c| c.were_picked_or_banned }

	return champions
end

def get_most_used_champion(champions)
	most_used = Champion.new(nil, 0, 0, 0, 0)
	champions.each { |c| 
		if most_used.picks_and_bans < c.picks_and_bans
			most_used = c
		end
	}
	return most_used
end

def write_graphs(champions)
	puts "Creating image ByPicksAndBans"
	champions.sort! { |a, b| b.picks_and_bans <=> a.picks_and_bans }
	@graph.draw(champions, "ByPicksAndBans")

	puts "Creating image ByPicks"
	champions.sort! { |a, b| b.picks <=> a.picks }
	@graph.draw(champions, "ByPicks")

	puts "Creating image ByWins"
	champions.sort! { |a, b| b.wins <=> a.wins }
	@graph.draw(champions, "ByWins")

	puts "Creating image ByLosses"
	champions.sort! { |a, b| b.losses <=> a.losses }
	@graph.draw(champions, "ByLosses")

	puts "Creating image ByWinToLossRatio"
	champions.sort! { |a, b| b.win_to_loss_ratio <=> a.win_to_loss_ratio }
	@graph.draw(champions, "ByWinToLossRatio")

	champions.keep_if { |c| c.were_banned }

	puts "Creating image ByBans"
	champions.sort! { |a, b| b.bans <=> a.bans }
	@graph.draw(champions, "ByBans")

	puts "Creating image ByPicksToBansRatio"
	champions.sort! { |a, b| b.picks_to_bans_ratio <=> a.picks_to_bans_ratio }
	@graph.draw(champions, "ByPicksToBansRatio")
end

Jobs.jobs.each do |key, job|
	champion_stats = []

	job[:urls].each do |url|
		@s = Scraper.new(url)

		champions = get_champions(url)
		champion_stats = champions
	end

	# TODO: ADD TOGETHER CHAMPION STATS
	#champion_stats.each do |champs|
	#	final_champ_stats += champs
	#end

	# Save job data in csv
	if !File.directory?("data/" + job[:short_name]) 
		Dir.mkdir("data/" + job[:short_name], 0755)
	end

	CSV.open("data/" + job[:short_name] + "/data.csv", "wb") do |csv|
		champion_stats.each do |c|
			csv << c.to_a
		end
	end

	# Write graphs
	most_used = get_most_used_champion(champion_stats)

	graph_width = most_used.picks_and_bans

	@graph = Graph.new(job[:name], job[:urls][0], graph_width, job[:short_name])

	write_graphs(champion_stats)
end