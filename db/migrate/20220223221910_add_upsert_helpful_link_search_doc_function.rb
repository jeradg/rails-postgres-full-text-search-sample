# frozen_string_literal: true

class AddUpsertHelpfulLinkSearchDocFunction < ActiveRecord::Migration[7.0]
  def up
    execute Rails.root.join('app/sql/upsert_helpful_link_search_doc.sql').read
  end

  def down
  end
end
