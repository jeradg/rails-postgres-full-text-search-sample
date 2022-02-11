class CreateHelpfulLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :helpful_links do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
