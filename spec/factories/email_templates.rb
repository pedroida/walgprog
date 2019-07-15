FactoryBot.define do
  factory :email_template do
    name { |n| "Name #{n}" }
    content_markdown { write_markdown }
    update_link_title { 'update info' }
    unregister_link_title { 'unregister' }
  end

  def write_markdown
    <<-MARKDOWN.strip_heredoc
        # Effugiam erit cinerem tenuere concurrere
        ## Mihi persequar et trementi muris constant tibique
        Lorem markdownum, abstulerunt preces prima. Ripas et concipit **genuit**.
    MARKDOWN
  end
end
