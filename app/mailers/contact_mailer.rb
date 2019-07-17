class ContactMailer < ApplicationMailer
  include EmailTemplateContent

  def welcome
    @contact = params[:contact]
    @template = EmailTemplate.find_by name: I18n.t('email_template.welcome_mail')
    @content = generate_content(@template, @contact)

    mail(to: @contact.email_with_name, subject: @template.subject)
  end

  def confirmation
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.confirmation.subject'))
  end

  def update
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.update.subject'))
  end

  def updated
    @contact = params[:contact]
    @template = EmailTemplate.find_by name: I18n.t('email_template.update_contact')
    @content = generate_content(@template, @contact)

    mail(to: @contact.email_with_name, subject: @template.subject)
  end
end

# settings app rails
# action mailer template define by user
