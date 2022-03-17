# frozen_string_literal: true

class InstallHelpfulLinkSearchDocTriggers < ActiveRecord::Migration[7.0]
  def up
    execute Rails.root.join('app/sql/helpful_link_search_doc_triggers.sql').read
  end

  def down
  end
end
