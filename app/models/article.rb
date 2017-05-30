class Article < ApplicationRecord
  extend FriendlyId
  include PgSearch
  acts_as_taggable
  friendly_id :title, use: :slugged

  pg_search_scope :search_for, against: { title: 'A', body: 'B' },
    using: {
        tsearch: {
          prefix: true,
          any_word: true
        }
    }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
