require 'spec_helper'

describe Scraper do
	describe "scrape" do
		it "should return an array of Champions" do
			# the file contains sourcode of the following url:
			# http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Season
			path = "spec/testdata/leaguepedia-eulcs-springseason.html"
			s = Scraper.new(path)
			champion_stats = s.scrape_champions
			champion_stats.each do |c|
				expect(c).to be_a_kind_of(Champion)
			end
		end
	end
end
