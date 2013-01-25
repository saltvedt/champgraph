require 'nokogiri'
require 'open-uri'

class Scraper

	def initialize(url)
		@doc = Nokogiri::HTML(open(url))
	end

	# Returns an array of Champions
	def scrape_champions
		@doc.css('center table tr').map do |tr|
			name = tr.css('td a:nth-child(2)').text.strip
			bans = tr.css('td:nth-child(2)').text.strip.to_i
			picks = tr.css('td:nth-child(3)').text.strip.to_i
			wins = tr.css('td:nth-child(4)').text.strip.to_i
			losses = tr.css('td:nth-child(5)').text.strip.to_i
			Champion.new(name, bans, picks, wins, losses)
		end
	end

	def scrape_title
		@doc.css('#firstHeading').text.gsub(/\s+|\//, '')
	end

end