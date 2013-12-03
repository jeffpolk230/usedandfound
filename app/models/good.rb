class Good < ActiveRecord::Base
  validates :title, :presence => true
  validates :price, :numericality => { greater_than: 0 }
  
  belongs_to :user
  
  before_create :assign_default_status
  
  %w(open close warned).each do |method|
    define_method( "#{method}!" ) { self.status = method }
    define_method( "#{method}?" ) { self.status == method }
    scope "all_#{method}", -> { where :status => method }
  end
  
  def owned_by?( user )
    self.user_id == user.id
  end
  
  protected
  def assign_default_status
    self.status ||= 'open'
  end
  
  
end
