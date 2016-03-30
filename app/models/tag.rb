class Tag < ActiveRecord::Base
  validates :name, presence: true

  has_many :taggings, dependent: :destroy
  has_many :entities, through: :taggings

  def self.stats
    joins(:taggings).group(:name).count
  end
end
