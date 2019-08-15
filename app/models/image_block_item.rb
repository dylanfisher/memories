class ImageBlockItem < ApplicationRecord
  belongs_to :image_block, optional: true
  belongs_to :media_item, optional: true
end
