class CollageBlockItem < ApplicationRecord
  belongs_to :media_item, optional: true, touch: true
  belongs_to :collage_block, optional: true, touch: true

  def css_styles
    styles = []
    styles << "width: #{collage_item_width}%"
    styles << "height: #{collage_item_height}%"
    styles << "top: #{collage_position_top}%"
    styles << "left: #{collage_position_left}%"
    styles << "z-index: #{collage_z_index}"
    styles.join('; ')
  end
end
