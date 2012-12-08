require 'nokogiri'
require 'open-uri'

class Scraper

	def scrape
		#http://leaguepedia.com/wiki/IGN_ProLeague_Season_5/Picks_and_Bans
		doc = Nokogiri::HTML(File.open('lol.html'))

		#p doc.css('table tr td	')
		doc.css('center table tr').map do |tr|
			#p tr.inspect
			name = tr.css('td a:nth-child(2)').text.strip
			bans = tr.css('td:nth-child(2)').text.strip.to_i
			picks = tr.css('td:nth-child(3)').text.strip.to_i
			wins = tr.css('td:nth-child(4)').text.strip.to_i
			losses = tr.css('td:nth-child(5)').text.strip.to_i
			Champion.new(name, bans, picks, wins, losses)
		end
	end

end