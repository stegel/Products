module ProductTags
	include Radiant::Taggable

	desc %{ Get list of product categories. }

	tag "categories" do |tag|
		categories = Category.find(:all)
		
		result = []

		categories.each do |category|
			tag.locals.data = category
			result << tag.expand
		end

		result
	end

	tag "category_name" do |tag|
		tag.locals.data.name
	end

	tag "category_id" do |tag|
		tag.locals.data.id
	end
end
