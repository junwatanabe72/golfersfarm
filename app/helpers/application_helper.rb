module ApplicationHelper
 def lazysizes_image_tag(source, options={})
      options['data-src'] = asset_path(source)
      if options[:class].blank?
        options[:class] = "lazyload"
      else
        options[:class] = "lazyload #{options[:class]}"
      end
      image_tag("blue.jpg", options)
 end
end
