require_relative 'Scraper'
require_relative 'Champion'
require_relative 'Graph'

s = Scraper.new
url = ARGV[0]
champions = s.scrape(url)

champions.keep_if { |c| c.name != "" }

d = Graph.new(url)
champions.keep_if { |c| c.picks + c.bans > 0 }

champions.sort! { |a, b| b.picks+b.bans <=> a.picks+a.bans }
d.draw(champions, "ByPicksAndBans")

champions.sort! { |a, b| b.picks <=> a.picks }
d.draw(champions, "ByPicks")

champions.sort! { |a, b| b.wins <=> a.wins }
d.draw(champions, "ByWins")

champions.sort! { |a, b| b.losses <=> a.losses }
d.draw(champions, "ByLosses")

def div(x, y)
	if y == 0 then 
		return 1000000+x
	end
	if x == 0 then
		return 0-y
	end
	return x/y
end

champions.sort! { |a, b| div(b.wins,b.losses) <=> div(a.wins,a.losses) }
d.draw(champions, "ByWinToLossRatio")

champions.keep_if { |c| c.bans > 0 }

champions.sort! { |a, b| b.bans <=> a.bans }
d.draw(champions, "ByBans")

champions.sort! { |a, b| b.picks/b.bans <=> a.picks/a.bans }
d.draw(champions, "ByPicksToBansRatio")
