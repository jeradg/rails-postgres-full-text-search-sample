# frozen_string_literal: true

class SearchDoc < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  default_scope { select('search_docs.*') }

  scope :with_highlights, lambda {
    selection_options = 'StartSel = [HIGHLIGHT], StopSel = [/HIGHLIGHT]'

    scope = select <<~SQL
      ts_headline('english', search_docs.title, query, '#{selection_options}') highlighted_title,
      ts_headline('english', left(search_docs.body, 2500), query, '#{selection_options}') highlighted_body
    SQL

    merge(scope)
  }

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
