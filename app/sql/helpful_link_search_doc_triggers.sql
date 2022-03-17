CREATE OR REPLACE FUNCTION upsert_helpful_link_search_doc_on_change() RETURNS TRIGGER AS $$
BEGIN
  perform upsert_helpful_link_search_doc(new.id);

  RETURN NULL;
END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION delete_helpful_link_search_doc_on_delete() RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM search_docs WHERE searchable_id = old.id AND searchable_type = 'HelpfulLink';

  RETURN NULL;
END;
$$ language plpgsql;


DROP TRIGGER IF EXISTS upsert_helpful_link_search_doc_on_change ON helpful_links;
CREATE TRIGGER upsert_helpful_link_search_doc_on_change AFTER INSERT OR UPDATE ON helpful_links
  FOR EACH ROW EXECUTE PROCEDURE upsert_helpful_link_search_doc_on_change();

DROP TRIGGER IF EXISTS delete_helpful_link_search_doc_on_delete ON helpful_links;
CREATE TRIGGER delete_helpful_link_search_doc_on_delete AFTER DELETE ON helpful_links
  FOR EACH ROW EXECUTE PROCEDURE delete_helpful_link_search_doc_on_delete();
