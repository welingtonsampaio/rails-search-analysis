class CreateSearchConsultings < ActiveRecord::Migration
  def change
    create_table :search_consultings do |t|
      t.string :term
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
