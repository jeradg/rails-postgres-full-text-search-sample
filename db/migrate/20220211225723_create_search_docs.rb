class CreateSearchDocs < ActiveRecord::Migration[7.0]
  def change
    create_table :search_docs do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.tsvector :tsv, null: false, index: { using: :gin }
      t.references :searchable, polymorphic: true, null: false

      # We manually declare the timestamps here because we will be
      # exclusively creating/updating search docs using postgres
      # functions, and therefore will be skipping ActiveRecord
      # callbacks that would otherwise populate the timestamp fields
      t.timestamp :created_at, null: false, default: -> { 'now()' }
      t.timestamp :updated_at, null: false, default: -> { 'now()' }

      t.index [:searchable_id, :searchable_type], unique: true
    end
  end
end
