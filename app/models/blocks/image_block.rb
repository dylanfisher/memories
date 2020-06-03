class ImageBlock < BaseBlock
  has_many_ordered :media_items, through: :image_block_items

  def self.permitted_params
    [:media_item_range, :media_item_skip_range, media_item_ids: []]
  end

  def self.display_name
    'Image Block'
  end

  def self.display_icon
    'glyphicon glyphicon-picture'
  end

  def media_items_to_use
    media_items_from_range.presence || media_items
  end

  def media_items_from_range
    return MediaItem.none if media_item_range.blank?
    MediaItem.where(id: parse_range(media_item_range))
             .where.not(id: media_items_to_skip_from_range)
             .by_id(:asc)
  end

  def media_items_to_skip_from_range
    MediaItem.where(id: parse_range(media_item_skip_range))
  end

  private

    def parse_range(value)
      if value.to_s.include?(',')
        value.split(',').collect { |v| v.strip.to_i }
      elsif value.to_s.include?('-')
        range = value.split('-').collect { |v| v.strip.to_i }[0..1]
        (range[0]..range[1])
      else
        value.to_i
      end
    end
end
