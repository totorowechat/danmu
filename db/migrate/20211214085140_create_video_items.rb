class CreateVideoItems < ActiveRecord::Migration[6.1]
  def change
    create_table :video_items do |t|
      t.string :title
      t.string :url
      t.string :site
      t.string :streams
      t.string :extra

      t.timestamps
    end
  end
end
