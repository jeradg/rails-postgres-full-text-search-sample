class SearchDoc < ApplicationRecord
  belongs_to :searchable, polymorphic: true
end
