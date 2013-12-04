class MarketController < ApplicationController
  def index
    @goods = Good.all_open
    @categories = Category.all
  end
  
  def search
    @keyword = params[:keyword]
    @results = Good.all_open
                  .includes( :user )
                  .where 'title ilike :q or description ilike :q or users.email ilike :q' , :q => "%#{@keyword}%"
    
    #render 'index'
  end
  
  def category
    @categories = Category.all
    @category = Category.find params[:id]
    @goods = @category.goods
  end
   
end
