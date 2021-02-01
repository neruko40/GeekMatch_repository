class RenameTypeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :type, :kind
  end
end
