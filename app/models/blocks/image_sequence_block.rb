class ImageSequenceBlock < BaseBlock
  has_many_ordered :media_items, through: :image_sequence_block_slides

  def self.permitted_params
    [:duration, :col_size, :col_offset, media_item_ids: []]
  end

  def self.display_name
    'Image Sequence Block'
  end

  def self.display_icon
    'glyphicon glyphicon-picture'
  end

  def image_size
    case
    when col_size < 4
      :small
    when col_size < 7
      :medium
    else
      :large
    end
  end
end
