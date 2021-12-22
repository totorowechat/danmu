# frozen_string_literal: true

class CreateSearchHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :search_histories do |t|
      t.references :video_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
