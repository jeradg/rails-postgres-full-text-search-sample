CREATE OR REPLACE FUNCTION upsert_helpful_link_search_doc(helpful_link_to_reindex_id bigint) RETURNS void AS $$

BEGIN
  INSERT INTO search_docs (searchable_id, searchable_type, title, body, tsv, updated_at)
    SELECT
      helpful_links.id searchable_id,
      'HelpfulLink' searchable_type,
      coalesce(helpful_links.title, '') title,
      coalesce(helpful_links.description, '') body,
      setweight(
        to_tsvector(
          'pg_catalog.english',
          coalesce(helpful_links.title, '')
        ),
        'A'
      ) ||
      setweight(
        to_tsvector(
          'pg_catalog.english',
          coalesce(helpful_links.description, '')
        ),
        'D'
      )
      tsv,
      now() updated_at
    FROM helpful_links
    WHERE id = helpful_link_to_reindex_id

  ON CONFLICT (searchable_id, searchable_type)
  DO UPDATE
  SET title = excluded.title,
      body = excluded.body,
      tsv = excluded.tsv;
END;
$$ LANGUAGE plpgsql;
