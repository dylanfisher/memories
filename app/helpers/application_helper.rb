module ApplicationHelper
  def exif_data(media_item)
    d = media_item.exif_data
    data = [
      "#{d['exposure_time']} at f / #{d['aperture_value']}, ISO #{d['iso_speed_ratings']}",
      d['lens_model']
    ].join('<br>').html_safe
    content_tag :div, class: 'exif-data caption' do
      content_tag :span, data, class: 'exif-data__text'
    end
  end
end
