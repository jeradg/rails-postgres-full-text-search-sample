# frozen_string_literal: true

namespace :search_docs do
  desc 'index helpful links for search'
  task index_helpful_links: :environment do
    execute <<~SQL
      SELECT upsert_helpful_link_search_doc(id) FROM helpful_links;
    SQL
  end

  def execute(string)
    ActiveRecord::Base.connection.execute(string)
  end
end
