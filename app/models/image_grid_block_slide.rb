class ImageGridBlockSlide < ApplicationRecord
  belongs_to :image_grid_block, optional: true
  belongs_to :media_item, optional: true
end
