class AddAvatarToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :picture, :string
  end
end
