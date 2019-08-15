module ImageVideoHelper
  def lazy_image(media_item, options = {})
    size = options.delete(:size) || :large
    data = options.delete(:data) || {}
    easein = options.fetch(:easein, true)

    alt = options.delete(:alt) || media_item.alternative_text
    skip_jump_fix = options.delete(:skip_jump_fix)
    constrained_height = options.delete(:constrained_height)

    options.merge!(alt: alt) if alt.present?

    styles = media_item.attachment.options[:styles]
    index = [styles.find_index { |k, v| k == size }, 2].max
    size_mobile = options.delete(:size_mobile) || (size == :large ? styles.keys[index - 1] : size)

    expand = easein ? -100 : nil

    data.merge!(src: media_item.attachment.url(size),
                src_mobile: media_item.attachment.url(size_mobile),
                src_full: media_item.attachment.url(:medium),
                src_full_mobile: media_item.attachment.url(:large),
                expand: expand)

    if options.delete(:background)
      options.merge!('aria-label': alt) if alt.present?
      options.delete(:alt)
      content_tag :div,
                  nil,
                  class: "lazy-image lazy-image--background lazyload #{options.delete(:class)}",
                  role: 'img',
                  data: {
                    bg: data.delete(:src),
                    bg_mobile: data.delete(:src_mobile),
                    **data
                  },
                  **options
    else
      image_content = capture do
        image_tag uri_image_placeholder, class: "lazy-image lazyload #{options.delete(:class)}", data: data, **options
      end

      if skip_jump_fix
        image_content
      else
        if constrained_height
          content_tag :div, class: 'constrained-height-image', style: "max-width: #{media_item.aspect_ratio * 100}vh;" do
            image_jump_fix media_item, class: options.delete(:wrapper_class) do
              image_content
            end
          end
        else
          image_jump_fix media_item, class: options.delete(:wrapper_class) do
            image_content
          end
        end
      end
    end
  end

  def lazy_video(block, options = {})
    data = options.delete(:data) || {}
    src = options.delete(:src) || options.delete(:video_item).try(:attachment).try(:url) || block.media_item.attachment.url
    src_mobile = options.delete(:src_mobile) || options.delete(:video_item_mobile).try(:attachment).try(:url) || block.try(:media_item_mobile).try(:attachment).try(:url)
    poster_media_item = options.delete(:poster_media_item)
    options.merge!(poster: poster_media_item.attachment.url(:large)) if poster_media_item.present?
    autoplay = options.fetch(:autoplay, block.try(:autoplay))
    controls = options.fetch(:controls, !autoplay)
    video_loop = options.fetch(:loop, autoplay)
    video_tag_html = capture do
      video_tag '',
                class: "lazy-video #{options.delete(:class)}",
                controls: controls,
                playsinline: autoplay,
                autoplay: autoplay,
                muted: autoplay,
                loop: video_loop,
                data: {
                  src: src,
                  src_mobile: src_mobile,
                  **data },
                **options
    end

    content_tag :div, nil, class: 'lazy-video-placeholder', data: { video_tag_html: video_tag_html }
  end

  def lazy_video_from_url(media_item, options = {})
    data = options.delete(:data) || {}
    poster_media_item = options.delete(:poster_media_item) || media_item
    options.merge!(poster: poster_media_item.attachment.url(:medium)) if poster_media_item.try(:attachment).present?
    autoplay = options.delete(:autoplay) || media_item.try(:autoplay)
    controls = options.fetch(:controls, !autoplay)
    loop = options.fetch(:loop, autoplay)
    video_tag_html = capture do
      video_tag '',
                class: "lazy-video #{options.delete(:class)}",
                controls: controls,
                playsinline: autoplay,
                autoplay: autoplay,
                muted: autoplay,
                loop: loop,
                data: {
                  src: (options.delete(:src) || media_item.try(:video_url)),
                  src_mobile: (options.delete(:src_mobile) || media_item.try(:video_url_mobile)),
                  object_fit: 'cover',
                  **data },
                **options
    end

    content_tag :div, nil, class: 'lazy-video-placeholder', data: { video_tag_html: video_tag_html }
  end

  def uri_image_placeholder
    'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
  end
end
