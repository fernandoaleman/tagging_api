class Entity < ActiveRecord::Base
  validates :entity_type, :entity_id, presence: true
  validates :entity_id, uniqueness: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
