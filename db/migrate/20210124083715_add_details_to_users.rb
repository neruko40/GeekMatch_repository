class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile, :text
    add_column :users, :age, :integer, default: 0, limit: 1
    add_column :users, :language, :string
  end
end
