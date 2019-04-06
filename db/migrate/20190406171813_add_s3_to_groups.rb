class AddS3ToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :s3, :string
  end
end
