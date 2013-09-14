require 'spec_helper'

describe Scraper do
	describe "scrape" do
		it "should return an array of Champions" do
			url = "http://lol.gamepedia.com/Riot_League_Championship_Series/Europe/Season_3/Picks_and_Bans/Spring_Season"
			s = Scraper.new(url)
			champion_stats = s.scrape_champions
			champion_stats.each do |c|
				c.should be_a_kind_of(Champion)
			end
		end
	end
end
