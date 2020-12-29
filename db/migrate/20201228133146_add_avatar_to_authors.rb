class AddAvatarToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :avatar, :string
  end
end
