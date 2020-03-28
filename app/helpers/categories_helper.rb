module CategoriesHelper
    def category_all
      @categories = Category.all
      return @categories
    end
end
