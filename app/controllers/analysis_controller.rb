class AnalysisController < ApplicationController
  def data
    counts = SearchConsulting.where.not('article_id' => nil).group(:article_id).count(:article_id).sort {|a,b| a <=> b }
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
    counts = SearchConsulting.where('article_id' => nil).group(:term).count(:term)
    asd
    @analysis = []
    counts.each do |data|
      a = Article.find_by_id data[0]
      @analysis << {
          term: a,
          total: data[1]
      }

    end
    render json: @analysis
  end
  
  def delete_by_term
    SearchConsulting.where(term: params[:term]).destroy_all
    render status: :no_content, nothing: true
  end
end
