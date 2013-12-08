class Quotation < ActiveRecord::Base
  validates_presence_of :author_name, :quote_category, :quote
 
 
  def self.search(search, sorting, disabled_id)
    if disabled_id != nil

      objArray = Array.new
      disabled_id.to_s.split(',').each { |x| objArray.push x }
      where("id NOT IN (?) AND (author_name iLIKE ? OR quote iLIKE ?)", Array(objArray), "%#{search}%", "%#{search}%").all(:order => sorting).to_a
    else
      puts "nil 4 sure :)"
      find(:all, :conditions => ['author_name iLIKE ? OR quote iLIKE ?', "%#{search}%", "%#{search}%"], :order => sorting)
    end
  end
end
