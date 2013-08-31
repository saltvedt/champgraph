require 'RMagick'
include Magick

class Graph
	def initialize(title, url, graph_width, short_name)
		@title = title
		@url = url
		@graph_width = graph_width
		@short_name = short_name
	end

	def draw(champions, name)
		header_h = 100
		champion_h = 20
		footer_h = 100
		margin_left = 20

		w = 900
		h = header_h + champion_h * champions.count + footer_h
		champion_w = ((w-150)/@graph_width).floor

		@img = Image.new(w, h)

		@img = @img.composite(header(name, header_h), margin_left, 0, Magick::OverCompositeOp)

		offset = header_h
		champions.each do |c|
			@img = @img.composite(champ(c, champion_w), margin_left, offset, Magick::OverCompositeOp)
			offset += champion_h
		end
		
		@img = @img.composite(footer(header_h), margin_left, h-footer_h, Magick::OverCompositeOp)

		graphs_directory = 'data/' + @short_name
		if !File.directory?(graphs_directory) 
			Dir.mkdir(graphs_directory, 0755)
		end
		@img.write(graphs_directory + '/' + name + '.png')
	end

	private

	def header(name, h)
		img_h = Image.new(@img.columns, h)

		gc = Draw.new
		gc.annotate(img_h, 0 ,0 , 30, 50, name) {
			self.pointsize = 34
			self.fill = "#000000"
		}

		base = 150
		gc.annotate(img_h, 0 ,0 , base*1, 80, "Wins") {
			self.pointsize = 18
			self.fill = "green"
		}

		gc.annotate(img_h, 0 ,0 , base*2, 80, "Losses") {
			self.pointsize = 18
			self.fill = "red"
		}

		gc.annotate(img_h, 0 ,0 , base*3, 80, "Bans") {
			self.pointsize = 18
			self.fill = "black"
		}

		return img_h
	end

	def champ(champ, factor)
		img_c = Image.new(@img.columns, 20)

		gc = Draw.new
		gc.annotate(img_c, 0 ,0 , 0, 15, champ.name) {
			self.pointsize = 16
			self.fill = "#000000"
		}

		top_margin = 5
		bot_margin = 15
		text_margin = 125
		wins_end = text_margin + champ.wins * factor
		losses_end = wins_end + champ.losses * factor
		bans_end = losses_end + champ.bans * factor

		if champ.wins > 0
			gc.fill('#2b2')
			gc.rectangle(text_margin, top_margin, wins_end, bot_margin)
		end

		if champ.losses > 0
			gc.fill('#b22')
			gc.rectangle(wins_end, top_margin, losses_end, bot_margin)
		end

		if champ.bans > 0
			gc.fill('#222')
			gc.rectangle(losses_end, top_margin, bans_end, bot_margin)		
		end

		ticks_colour = '#fff'

		(0..champ.picks_and_bans*factor).step(factor).to_a.each { |x|
			gc.fill(ticks_colour)
			gc.rectangle((text_margin+x)-1, top_margin, (text_margin+x), bot_margin)
		}

		gc.draw(img_c)

		return img_c
	end

	def footer(h)
		img_f = Image.new(@img.columns, h)

		gc = Draw.new
		gc.annotate(img_f, 0 ,0 , 30, 50, "Source: " + @url) {
			self.pointsize = 14
			self.fill = "black"
		}

		return img_f
	end
end