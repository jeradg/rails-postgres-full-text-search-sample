# frozen_string_literal: true

class SearchDoc < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  default_scope { select('search_docs.*') }

  scope :query, lambda { |webquery|
    joins(
      sanitize_sql([
        ", websearch_to_tsquery('english', '%s') query",
        webquery
      ])
    )
      .where('query @@ tsv')
  }
end
