class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :trackers, dependent: :destroy

  mount_uploader :picture, PictureUploader

  include PgSearch
  pg_search_scope :search_for, against: { title: 'A', body: 'B' },
    using: {
        tsearch: {
          prefix: true,
          any_word: true
        }
    }

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true
  validates_processing_of :picture
  validate :image_size_validation
  validates :description, length: { maximum: 400 }

  before_save :default_description

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  private

  def image_size_validation
    errors[:picture] << 'should be less than 10 mb' if picture.size > 10.megabytes
  end

  def default_description
    self.description = body.truncate(400) if description.blank?
  end
end
