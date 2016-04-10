class SearchConsulting < ActiveRecord::Base
  belongs_to :article

  after_save :sync_counter
  after_destroy :sync_counter

  # Synchronizes the Article click count
  def sync_counter
    if article.present?
      Indexer.perform_async :index, article.id
    end
  end
end
