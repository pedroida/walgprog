module ContentMarkdown
  extend ActiveSupport::Concern

  included do
    before_save :markdown_to_html

    def markdown_to_html
      config = MarkdownConfig.new

      renderer = Redcarpet::Render::HTML.new(config.options)
      markdown = Redcarpet::Markdown.new(renderer, config.extensions)

      self.content = markdown.render(content_markdown)
    end
  end
end
