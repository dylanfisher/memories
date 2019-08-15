class ImageBlock < BaseBlock
  has_many_ordered :media_items, through: :image_block_items

  def self.permitted_params
    [media_item_ids: []]
  end

  def self.display_name
    'Image Block'
  end

  def self.display_icon
    'glyphicon glyphicon-picture'
  end
end
