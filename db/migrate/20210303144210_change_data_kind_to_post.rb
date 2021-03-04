class ChangeDataKindToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :kind, :string
  end
end
