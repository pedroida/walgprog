require 'rails_helper'

RSpec.describe EmailTemplate, type: :model do
  describe 'validates' do
    [:name, :content_markdown].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
