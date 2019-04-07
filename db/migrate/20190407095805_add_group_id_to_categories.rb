class AddGroupIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :group, foreign_key: true
  end
end
