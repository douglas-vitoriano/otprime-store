class Product < ApplicationRecord
  scope :published, -> { where(publish: true) }
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :big_thumb, resize_to_limit: [600, 700]
  end
  has_many :orderables
  has_many :carts, through: :orderables
  belongs_to :category
  before_destroy :purge_attached

  validates :name, :description, :price, presence: true
  validate :image_attached

  def image_link
    if self.image.attached?
      self.image.variant(resize_to_limit: [100, 100]).processed.url
    else
      "https://via.placeholder.com/100x100?text=Sem+imagem"
    end
  end

  after_save do
    instance = self.image
    folder = "products"
    name = "file"
    record_type = "Product"
    record_id = self.image.blob.id
    ImageService.save(instance, folder, name, record_type, record_id)
  end

  private

  def purge_attached
    image.purge if image.attached?
  end

  def image_attached
    errors.add(:image, "must be attached") unless image.attached?
  end
end
