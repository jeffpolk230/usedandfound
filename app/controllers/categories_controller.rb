class CategoriesController < ApplicationController
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new
    if current_user
      if @category.save
        flash[:message] = "#{@category.category_title} is created"
        redirect_to market_path
  end
  
  def edit
  end
  
  def update 
  end
  
  def show
  end
  
  private 
  def category_params( params )
    params.require( :category ).permit( :category_title )
  end
end
