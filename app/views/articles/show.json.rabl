object @article

attributes :title, :content, :created_at, :updated_at

node :url do |article|
    article_path(article.id)
end