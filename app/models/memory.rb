class Memory < Forest::ApplicationRecord
  include Blockable
  include Sluggable
  include Statusable

  scope :by_date, -> (orderer = :desc) { order(date: orderer) }

  # def self.resource_description
  #   'Briefly describe this resource.'
  # end

  def media_items
    media_item_ids = []

    blocks.each do |b|
      media_item_ids.push(b.media_item_id) if b.try(:media_item_id).present?
      if b.try(:media_items_to_use).present?
        media_item_ids.concat(b.media_items_to_use.pluck(:id))
      elsif b.try(:media_item_ids).present?
        media_item_ids.concat(b.media_item_ids)
      end
    end

    if media_item_ids.present?
      MediaItem.where(id: media_item_ids.uniq)
    else
      MediaItem.none
    end
  end
end
