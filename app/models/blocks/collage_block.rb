class CollageBlock < BaseBlock
  has_many :collage_block_items, dependent: :destroy
  has_many :media_items, through: :collage_block_items

  accepts_nested_attributes_for :collage_block_items, allow_destroy: true, reject_if: proc { |attributes| attributes['media_item_id'].blank? }

  def self.permitted_params
    [
      :collage_height_ratio,
      collage_block_items_attributes: [
        :id, :_destroy, :media_item_id, :collage_block_id,
        :collage_position_left, :collage_position_top, :collage_z_index, :collage_item_width, :collage_item_height
      ]
    ]
  end

  def self.display_name
    'Collage Block'
  end

  # def self.display_icon
  #   'glyphicon glyphicon-align-left'
  # end

  def collage_canvas_styles
    styles = []
    styles << "height: 0px"
    styles << "padding-bottom: #{collage_height_ratio}%"
    styles.join('; ')
  end
end
