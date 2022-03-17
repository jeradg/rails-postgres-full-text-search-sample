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
      .query(search_params[:query])
  end

  def search_params
    params.permit(:query)
  end

  def serialize(results)
    results.map { |result|
      {
        body: result.body,
        searchable_id: result.searchable_id,
        searchable_type: result.searchable_type,
        title: result.title,
        url: result.searchable.url,
      }
    }
  end
end
