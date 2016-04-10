class AnalysisController < ApplicationController
  skip_before_action :verify_authenticity_token

  def data
    counts = SearchConsulting.where.not('article_id' => nil).group(:article_id).count(:article_id).to_a.sort {|a,b| a[1] <=> b[1] }.reverse
    @analysis = []
    counts.each do |data|
      a = Article.find_by_id data[0]
      @analysis << {
          article: a,
          total: data[1]
      }

    end
    render json: @analysis
  end


  def not_found
    counts = SearchConsulting.where('article_id' => nil).group(:term).count(:term).to_a.sort {|a,b| a[1] <=> b[1] }.reverse
    @analysis = []
    counts.each do |data|
      @analysis << {
          term: data[0],
          total: data[1]
      }

    end
    render json: @analysis
  end
  
  def delete_by_term
    cookies.delete 'search'
    if params[:term].present?
      SearchConsulting.where(term: params[:term]).destroy_all
    else
      SearchConsulting.destroy_all
    end
    render status: :no_content, nothing: true
  end
end
