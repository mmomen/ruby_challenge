class Car
	def initialize
		@fuel = 10
		@distance = 0
		puts "the initialize method is running automatically"
	end
	def get_info
		return "I'm a car. I've driven #{@distance} miles and have #{@fuel} gallons of gas left."
	end
	def drive(miles)
		(0..miles).step(20) do |n|
			if @fuel == 0
				return "Out of gas, need to fuel up."
			else
				@distance += n
				@fuel = @fuel - (n / 20)
			end
		end
	end
	def fuel_up
		@fill_up = 10 - @fuel
		@fuel = @fill_up
		@cost = @fill_up * 3.50
		return "That will cost you $#{@cost}."
	end
end