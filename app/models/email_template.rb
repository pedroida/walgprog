class EmailTemplate < ApplicationRecord
  include ContentMarkdown

  validates :name, :content_markdown, presence: true
end
