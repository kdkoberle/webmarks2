class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :username
      t.string :name
      t.string :url
      t.string :date_saved

      t.timestamps
    end
  end
end
