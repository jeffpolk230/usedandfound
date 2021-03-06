class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :login ]
         
  attr_accessor :login
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "150x150>" }, :default_url => "/images/user_missing.jpg"

  has_many :goods
  validates :user_name, :presence => true, :uniqueness => true
  
  def self.find_first_by_auth_conditions( warden_conditions )
    conditions = warden_conditions.dup
    puts "Find first by auth conditions: #{conditions}"
    
    if login = conditions.delete( :login )
      where(conditions).where( "lower(user_name) = :value OR lower(email) = :value" , :value => login.downcase).first
    else
      where(conditions).first
    end
    
  end
end
