class ChangeDataAgeToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :Users, :age, :decimal, precision: 3
  end
end
