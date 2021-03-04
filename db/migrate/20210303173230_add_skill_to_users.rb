class AddSkillToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :skill, :string
  end
end
