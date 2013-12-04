class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :good
  validates :content, :presence => true  
  
  
  def owned_by?( user )
    user.id == self.user_id if user
  end
end
