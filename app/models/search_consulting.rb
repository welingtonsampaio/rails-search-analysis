class SearchConsulting < ActiveRecord::Base
  belongs_to :article

  after_save :sync_counter
  after_destroy :sync_counter

  def sync_counter
    if article.present?
      Indexer.perform_async :index, article.id
    end
  end
end
