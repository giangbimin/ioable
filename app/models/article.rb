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
  mount_uploader :picture, PictureUploader
  validates_processing_of :picture
  validate :image_size_validation

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  private

  def image_size_validation
    errors[:picture] << 'should be less than 10 mb' if picture.size > 10.megabytes
  end
end
