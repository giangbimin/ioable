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
  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true
  belongs_to :user

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
