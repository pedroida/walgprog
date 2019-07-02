require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  describe 'send welcome email' do
    let(:contact) { create(:contact) }
    let(:mail) { described_class.with(contacts: contact).welcome_email.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq(I18n.t('mail.welcome_email.subject'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([contact.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([ENV['mailer.from']])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(contact.name)
    end

    it 'assigns @unregister_url' do
      expect(mail.body.encoded)
        .to match(contact_confirm_unregister_path(contact, contact.unregister_token))
    end

    it 'assigns @update_url' do
      expect(mail.body.encoded)
        .to match(contact_edit_path(contact, contact.update_data_token))
    end
  end
end
