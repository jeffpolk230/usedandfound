class MarketController < ApplicationController
  def index
    @goods = Good.all_open
  end
  
  def search
    @keyword = params[:keyword]
    @results = Good.all_open
                  .includes( :user )
                  .where 'title ilike :q or description ilike :q or users.email ilike :q' , :q => "%#{@keyword}%"
    
    #render 'index'
  end
end
