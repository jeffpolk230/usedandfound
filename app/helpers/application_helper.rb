module ApplicationHelper
  def error_header( obj ) 
    if obj.errors.any?
      render :partial => 'layouts/error_header' , :locals => { :obj => obj }
    end
  end
end
