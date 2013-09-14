require 'spec_helper'

describe Champion do
	before(:each) do
		# Champion.new("name", "bans", "picks", "wins", "losses")
		@champion = Champion.new("Name", 5, 10, 15, 20)
		@unused_champion = Champion.new("Name", 0, 0, 0, 0)
		@invalid_champion = Champion.new(nil, nil, nil, nil, nil)
	end

	it "#picks_and_bans return the sum of picks and bans" do
		expect(@champion.picks_and_bans).to eq(15)
	end

	it "#win_to_loss_ratio should return ratio of win:loss" do
		expect(@champion.win_to_loss_ratio).to eq(0.75)
	end

	it "#picks_to_bans_ratio should return ratio of picks:losses" do
		expect(@champion.picks_to_bans_ratio).to eq(2)
	end

	it "#valid returns false if champion data is invalid" do
		expect(@invalid_champion.valid).to eq(false)
	end

	it "#were_picked_or_banned returns true or false depending on whether the champion were picked or banned" do
		expect(@champion.were_picked_or_banned).to eq(true)
		expect(@unused_champion.were_picked_or_banned).to eq(false)
	end

	it "#were_banned returns true or false depending on wheter the champion were banned or not" do
		expect(@champion.were_banned).to eq(true)
		expect(@unused_champion.were_banned).to eq(false)
	end

	it "#to_s returns a string representation of the champion" do
		expect(@champion.to_s).to eq("Name - 5 - 10 - 15 - 20")
	end

	it "#to_a returns an array with the champion data in string format" do
		expect(@champion.to_a).to eq(["Name", 5.to_s, 10.to_s, 15.to_s, 20.to_s])
	end

	describe ".ratio" do
		it "returns a float" do
			Champion::ratio(1,1).should be_a_kind_of(Float)
			Champion::ratio(1,0).should be_a_kind_of(Float)
			Champion::ratio(0,1).should be_a_kind_of(Float)
			Champion::ratio(5,3).should be_a_kind_of(Float)
			Champion::ratio(3,5).should be_a_kind_of(Float)
		end

		it "returns 1 when dividend and numerator are equal" do
			expect(Champion::ratio(1,1)).to eq(1.to_f)
			expect(Champion::ratio(5,5)).to eq(1.to_f)
			expect(Champion::ratio(10,10)).to eq(1.to_f)
		end

		it "returns 0 when dividend and numerator are zero" do
			expect(Champion::ratio(0,0)).to eq(0.to_f)
		end

		it "returns 0.5 when dividend is half of numerator" do
			expect(Champion::ratio(5,10)).to eq(0.5)
			expect(Champion::ratio(20,40)).to eq(0.5)
			expect(Champion::ratio(1,2)).to eq(0.5)
		end

		it "returns 0.333.. when dividend is a third of numerator" do
			expect(Champion::ratio(1,3)).to eq(1.0/3)
			expect(Champion::ratio(20,60)).to eq(1.0/3)
			expect(Champion::ratio(30,90)).to eq(1.0/3)
		end

		it "returns 0.75 when dividend is three quarters of numerator" do
			expect(Champion::ratio(3,4)).to eq(0.75)
			expect(Champion::ratio(15,20)).to eq(0.75)
			expect(Champion::ratio(75,100)).to eq(0.75)
		end
	end
end
