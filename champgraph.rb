require_relative 'Scraper'
require_relative 'Champion'
require_relative 'Graph'

url = ARGV[0]

s = Scraper.new(url)
title = s.scrape_title

puts "Scraping URL"
champions = s.scrape_champions

champions.keep_if { |c| c.valid }

champions.keep_if { |c| c.were_picked_or_banned }

graph = Graph.new(title, url)

puts "Creating image ByPicksAndBans"
champions.sort! { |a, b| b.picks_and_bans <=> a.picks_and_bans }
graph.draw(champions, "ByPicksAndBans")

puts "Creating image ByPicks"
champions.sort! { |a, b| b.picks <=> a.picks }
graph.draw(champions, "ByPicks")

puts "Creating image ByWins"
champions.sort! { |a, b| b.wins <=> a.wins }
graph.draw(champions, "ByWins")

puts "Creating image ByLosses"
champions.sort! { |a, b| b.losses <=> a.losses }
graph.draw(champions, "ByLosses")

puts "Creating image ByWinToLossRatio"
champions.sort! { |a, b| b.win_to_loss_ratio <=> a.win_to_loss_ratio }
graph.draw(champions, "ByWinToLossRatio")

champions.keep_if { |c| c.were_banned }

puts "Creating image ByBans"
champions.sort! { |a, b| b.bans <=> a.bans }
graph.draw(champions, "ByBans")

puts "Creating image ByPicksToBansRatio"
champions.sort! { |a, b| b.picks_to_bans_ratio <=> a.picks_to_bans_ratio }
graph.draw(champions, "ByPicksToBansRatio")
