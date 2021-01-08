class AddTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :token, :string
  end
end
