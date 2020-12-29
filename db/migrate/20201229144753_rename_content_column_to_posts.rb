class RenameContentColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :content, :text
  end
end
