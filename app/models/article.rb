class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
end
