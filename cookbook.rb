class Cookbook
	attr_accessor :title
	attr_reader :recipes
	def initialize(title)
		@title = title
		@recipes = []
	end
	def add_recipe(recipe)
		@recipes.push(recipe)
		puts "Added a recipe to the collection: #{recipe.title}"
	end
	def recipe_titles
		y = []
		@recipes.each do |x|
			y.push(x.title)
		end
		puts y.join(', ')
	end
	def recipe_ingredients
		@recipes.each do |x|
			puts "These are the ingredients for #{x.title}: #{x.ingredients}"
		end
	end
	def print_recipe
		puts "Title: #{@recipes[0].title}"
		puts "Ingredients: #{@recipes[0].ingredients}"
		puts "Steps: #{@recipes[0].steps}"
	end
	def print_cookbook
		@recipes.each do |x|
			puts "For a #{x.title} recipe, we would use the following ingredients, #{x.ingredients} and the below steps:"
			i = 1
			x.steps.each do |y|
				puts "#{i}. #{y}"
				i += 1
			end
		end
	end
end

class Recipe
	attr_accessor :title
	attr_accessor :steps
	attr_accessor :ingredients
	def initialize(title, ingredients, steps)
		@title = title
		@ingredients = ingredients
		@steps = steps
	end
end