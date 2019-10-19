class ImageSequenceBlockSlide < ApplicationRecord
  belongs_to :image_sequence_block, optional: true
  belongs_to :media_item, optional: true
end
