require 'net/http'
require 'rexml/document'

class Problemset2Controller < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    if (params[:search])
      puts search(params[:search], sort_column + ' ', cookies[:quotation_id]).length
    else
      @quotations = Quotation.order(sort_column + ' ' )
    end
  end
  
  def create
    @quotation = Quotation.new(quotation_params)
    @quotation.save
    redirect_to problemset2_index_path
  end
  
  def disable
    if cookies[:quotation_id]
      cookies[:quotation_id]={
        value: cookies[:quotation_id] + ',' + params[:id], 
        expires: 1.month.from_now
      }
    else #no cookies there
      cookies[:quotation_id]={
        value: params[:id],
        expires: 1.month.from_now
      }
    end
    redirect_to problemset2_index_path
  end

  def cleanup #cleaning up for user cookies
    cookies.delete :quotation_id
    redirect_to problemset2_index_path
  end

  def search (keywords, sorting, disabled_id)
    @quotations = Quotation.search(keywords, sorting, disabled_id)
    
  end
  
  def upload
    uploaded_io =  params[:upload_file]
    if(!File.directory?("#{Rails.root}/public/uploads"))
      FileUtils.mkpath "#{Rails.root}/public/uploads"
    end
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read)
    end
    
    f = File.open('public/uploads/' + uploaded_io.original_filename)
    fxml = REXML::Document.new(f)
    fxml.root.each_element do |fx|
      quot = Quotation.new
      fx.each_element do |x|
        if(x.name == "author-name")
          quot.author_name = x.text
        elsif (x.name == "quote_category")
          quot.quote_category = x.text
        elsif (x.name == "quote")
          quot.quote = x.text
        end
      end
      quot.save
    end
    
    redirect_to problemset2_index_path
    
  end
  
  
  private
  def quotation_params
    params.require(:quotation).permit(:author_name, :quote_category, :quote)
  end
  
  def sort_column
    Quotation.column_names.include?(params[:sort]) ? params[:sort] : "quote_category"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
