class AddMangaRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :manga_ref, :string
  end
end
