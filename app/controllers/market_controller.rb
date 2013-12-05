
class MarketController < ApplicationController

  def index
    @goods = Good.all_open.paginate( :page => page , :per_page => per_page )
    @categories = Category.all
  end
  
  def search
    @keyword = params[:keyword]
    @results = Good.all_open
                  .includes( :user )
                  .where('title @@ :q or description @@ :q or users.email ilike :q' , :q => @keyword)
                  .paginate( :page => page , :per_page => per_page )
    #render 'index'
  end
  
  def category
    @categories = Category.all
    @category = Category.find params[:id]
    @goods = @category.goods.all_open.paginate( :page => page , :per_page => per_page )
  end

  private
  def page
    params[:page] ? params[:page] : 1
  end
  
  def per_page
    6
  end
end
