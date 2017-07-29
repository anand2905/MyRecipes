class AddPictureToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :picture, :string
  end
end
