class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.string :image
      t.string :google_map_url

      t.timestamps
    end
  end
end
