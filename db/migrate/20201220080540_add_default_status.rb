class AddDefaultStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :status, :integer, default: 0
  end
end
