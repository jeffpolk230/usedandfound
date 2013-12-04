class CommentsController < ApplicationController
  
  # def new 
  #   @comment = Comment.new
  # end
  
  def create
    @comment = Comment.new comment_params( params )
    @good    = Good.find params[ :good_id ]
    @comment.good = @good
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to good_path( @good.id ) }
        format.js   { render 'create_success' }
      else
        format.html do
          flash[:error] = 'Cannot create comment'
          redirect_to good_path( @good.id )
        end
        format.js { render 'create_fail' }
      end
    end
  end
  
  def edit
    @good = Good.find params[ :good_id ]
    @comment = Comment.find params[ :id ]
  end
  
  def update
    @good = Good.find params[ :good_id ]
    @comment = Comment.find params[ :id ]
    
    respond_to do |format|
      if @comment.update_attributes( comment_params( params ) ) 
        format.html { redirect_to good_path( @good.id ) }
        format.js   { render "update_success" }
      else
        format.html do
          flash[:error] = 'Cannot update comment'
          redirect_to good_path( @good.id )
        end
        format.js { render 'update_fail' }
      end #if
    end #respond
  end #def
  
  def destroy
  end
  
  
  protected
  def comment_params( params )
    params.require( :comment ).permit( :content )
  end
  
end
