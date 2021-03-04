class ChangeDataLanguageToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :language, :string
  end
end
