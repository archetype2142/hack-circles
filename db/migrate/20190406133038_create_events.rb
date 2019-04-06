class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.string :address
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
