class RemoveAgeFromUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :age
  end
end
