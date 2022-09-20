class RemoveAuthorFromTitles < ActiveRecord::Migration[5.2]
  def change
    remove_column :titles, :password_digest, :string
  end
end
