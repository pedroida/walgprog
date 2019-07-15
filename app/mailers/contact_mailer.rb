class ContactMailer < ApplicationMailer
  include ActionView::Helpers::UrlHelper

  def welcome
    @contact = params[:contact]
    @template = EmailTemplate.find 1
    @update_link = link_to @template.update_link_title, contact_edit_url(@contact,
                                                                         @contact.update_token)
    @unregister_link = link_to @template.unregister_link_title,
                               contact_unregister_confirmation_url(@contact,
                                                                   @contact.unregister_token)

    @content = @template.get_replaced_content(@update_link, @unregister_link, @contact.name)

    mail(to: @contact.email_with_name, subject: I18n.t('mail.welcome_email.subject'))
  end

  def success_update
    @contact = params[:contact]
    @template = EmailTemplate.find 2
    @update_link = link_to @template.update_link_title, contact_edit_url(@contact,
                                                                         @contact.update_token)
    @unregister_link = link_to @template.unregister_link_title,
                               contact_unregister_confirmation_url(@contact,
                                                                   @contact.unregister_token)

    @content = @template.get_replaced_content(@update_link, @unregister_link, @contact.name)

    mail(to: @contact.email_with_name, subject: I18n.t('mail.updated.subject'))
  end
end

# settings app rails
# action mailer template define by user
