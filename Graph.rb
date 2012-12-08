require 'RMagick'
include Magick

class Graph
	def draw(champions, name)
		header_h = 100
		champion_h = 20
		footer_h = 100
		margin_left = 20

		w = 900
		h = header_h + champion_h * champions.count + footer_h

		@img = Image.new(w, h)

		@img = @img.composite(header(name, header_h), margin_left, 0, Magick::OverCompositeOp)

		offset = header_h
		champions.each do |c|
			@img = @img.composite(champ(c), margin_left, offset, Magick::OverCompositeOp)
			offset += champion_h
		end
		
		@img = @img.composite(footer(header_h), margin_left, h-footer_h, Magick::OverCompositeOp)

		@img.write('graphs/' + name + '.png')
	end

	def header(name, h)
		#legends, todo
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

	def champ(champ)
		img_c = Image.new(@img.columns, 20)

		gc = Draw.new
		gc.annotate(img_c, 0 ,0 , 0, 15, champ.name) {
			self.pointsize = 16
			self.fill = "#000000"
		}

		factor = 10
		top_margin = 5
		bot_margin = 15
		text_margin = 125
		wins_end = text_margin + champ.wins * factor
		losses_end = wins_end + champ.losses * factor
		bans_end = losses_end + champ.bans * factor

		gc.fill('green')
		gc.rectangle(text_margin, top_margin, wins_end, bot_margin)

		gc.fill('red')
		gc.rectangle(wins_end, top_margin, losses_end, bot_margin)

		gc.fill('black')
		gc.rectangle(losses_end, top_margin, bans_end, bot_margin)

		gc.draw(img_c)
		return img_c
	end

	def footer(h)
		#legends, todo
		img_f = Image.new(@img.columns, h)

		gc = Draw.new
		gc.annotate(img_f, 0 ,0 , 30, 50, "Source: http://leaguepedia.com/wiki/IGN_ProLeague_Season_5/Picks_and_Bans#Bracket_Stage") {
			self.pointsize = 14
			self.fill = "black"
		}

		return img_f
	end
end