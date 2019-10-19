class ImageGridBlock < BaseBlock
  has_many_ordered :media_items, through: :image_grid_block_slides

  def self.permitted_params
    [:col_size, media_item_ids: []]
  end

  def self.display_name
    'Image Grid Block'
  end

  def self.display_icon
    'glyphicon glyphicon-picture'
  end
end
