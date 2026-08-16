# frozen_string_literal: true

require "kramdown/converter/html"

module Jekyll
  module MarkdownImageLoading
    MARKER = "data-markdown-image-loading"
    IMAGE_TAG = /<img\b[^>]*>/i
    MARKED_IMAGE = /\s#{MARKER}="true"/i
    LOADING_ATTRIBUTE = /\sloading\s*=/i

    module Converter
      def convert_img(element, indent)
        # Raw HTML images bypass this converter and keep author-supplied behavior.
        element.attr[MARKER] = "true"
        super
      end

      # Kramdown renders images marked {:standalone} through a separate path.
      def convert_standalone_image(element, indent)
        element.children.first.attr[MARKER] = "true"
        super
      end
    end

    def self.apply(html)
      image_seen = false

      # Decide after layouts and excerpts are assembled so only the page's top
      # image is eager, rather than the first image in every Markdown fragment.
      html.gsub(IMAGE_TAG) do |tag|
        markdown_image = MARKED_IMAGE.match?(tag)
        tag = tag.sub(MARKED_IMAGE, "") if markdown_image

        if markdown_image && !LOADING_ATTRIBUTE.match?(tag)
          loading = image_seen ? "lazy" : "eager"
          tag = tag.sub(/(?=\s*\/?>\z)/, %( loading="#{loading}"))
        end

        image_seen = true
        tag
      end
    end
  end
end

Kramdown::Converter::Html.prepend(Jekyll::MarkdownImageLoading::Converter)

Jekyll::Hooks.register([:pages, :documents], :post_render) do |item|
  item.output = Jekyll::MarkdownImageLoading.apply(item.output)
end
