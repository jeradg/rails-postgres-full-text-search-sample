# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    records = fetch_results

    payload = { hits: serialize(records) }

    render json: payload
  end

  private

  def fetch_results
    SearchDoc
      .includes(:searchable)
      .with_rank
      .with_highlights
      .query(search_params[:query])
      .order({ rank: :desc })
  end

  def search_params
    params.permit(:query)
  end

  def serialize(results)
    results.map { |result|
      {
        body: result.highlighted_body,
        searchable_id: result.searchable_id,
        searchable_type: result.searchable_type,
        title: result.highlighted_title,
        url: result.searchable.url,
      }
    }
  end
end
