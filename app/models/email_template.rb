class EmailTemplate < ApplicationRecord
  include ContentMarkdown

  validates :name, :content_markdown, presence: true

  def get_replaced_content(update_link, unregister_link, name = I18n.t('helpers.user'))
    content.sub! '@nome', name
    content.sub! '@linkAtualizar', update_link
    content.sub! '@linkDesregistrar', unregister_link
  end
end
