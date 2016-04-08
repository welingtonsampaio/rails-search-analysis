class ArticlesController < ApplicationController
  before_action :set_article, only: :show

  # GET /articles
  def index
    if params[:s].present?
      @articles = Article.s(params[:s]).records.to_a
      if cookies[:search].present?
        s = SearchConsulting.find cookies[:search]
        s.update_attributes term: params[:s]
      else
        s = SearchConsulting.create term: params[:s]
        cookies[:search] = s.id.to_s
      end
    else
      @articles ||= Article.all
    end
  end

  # GET /articles/1
  def show
    if cookies[:search].present?
      id = cookies.delete :search
      sc = SearchConsulting.find id
      sc.term = @article.title
      sc.article_id = @article.id
      sc.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
