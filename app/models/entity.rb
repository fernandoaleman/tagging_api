class Entity < ActiveRecord::Base
  validates :entity_type, :entity_id, presence: true
  validates :entity_id, uniqueness: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  after_destroy :destroy_unused_tags

  def destroy_unused_tags
    unused_tags = Tag.includes(:taggings).where(taggings: {tag_id: nil})
    unused_tags.each { |tag| tag.destroy }
  end

  def tag_names
    tags.pluck(:name)
  end
end
