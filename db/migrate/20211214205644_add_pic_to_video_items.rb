class AddPicToVideoItems < ActiveRecord::Migration[6.1]
  def change
    add_column :video_items, :pic, :string
  end
end
