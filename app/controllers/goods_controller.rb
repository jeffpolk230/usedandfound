class GoodsController < ApplicationController
  before_action :require_logged_in, :only => [ :new , :create , :edit , :update , :close , :warn ]
  before_action :recheck_owner, :only => [ :edit , :update , :close ]
  
  def new 
    @good = Good.new
  end
  
  def create
    @good = Good.new good_params( params )
    @good.user = current_user if current_user
    
    if @good.save
      flash[:message] = "#{@good.title} is created"
      redirect_to good_path( @good.id )
    else
      render 'new'
    end
  end
  
  def edit
    #@good = Good.find params[:id]
  end
  
  def update
    #@good = Good.find params[:id]
    if @good.update_attributes good_params( params )
      flash[:message] = "#{@good.title} is updated"
      redirect_to good_path( @good.id )
    else
      render 'edit'
    end
  end 
  
  def show
    @good = Good.find params[:id]
  end
  
  def close
    #@good = Good.find params[:id]
    @good.close!
    @good.save
    
    redirect_to good_path( @good.id )
  end
  
  def warn
    @good = Good.find params[:id]
    @good.warned!
    @good.save
    
    redirect_to good_path( @good.id )
  end
  
  private
  def good_params( params )
    params.required( :good ).permit( :title , :price , :description )
  end
  
  def require_logged_in
    unless user_signed_in?
      flash[:error] = 'Please Log In before posting goods'
      redirect_to new_user_session_path 
    end
  end
  
  def recheck_owner
     @good = Good.find params[:id]
    unless @good.owned_by?( current_user )
      flash[:error] = 'You dont own this item!'
      redirect_to good_path( @good.id )
    end
  end

end
