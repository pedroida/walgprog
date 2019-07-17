class ContactMailer < ApplicationMailer
  include EmailTemplateContent

  def welcome
    @contact = params[:contact]
    @template = EmailTemplate.find_by name: I18n.t('email_template.welcome_mail')
    @content = generate_content(@template, @contact)

    mail(to: @contact.email_with_name, subject: @template.subject)
  end

  def success_update
    @contact = params[:contact]
    @template = EmailTemplate.find_by name: I18n.t('email_template.update_contact')
    @content = generate_content(@template, @contact)

    mail(to: @contact.email_with_name, subject: @template.subject)
  end
end

# settings app rails
# action mailer template define by user
