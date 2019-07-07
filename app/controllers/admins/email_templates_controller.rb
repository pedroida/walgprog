class Admins::EmailTemplatesController < Admins::BaseController

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.email_template.other')),
                 :admins_email_templates_path, only: [:index, :edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.email_template.one')),
                 :edit_admins_email_template_path, only: [:edit, :update]

  before_action :set_template, only: [:edit, :update, :show]

  def index
    @templates = EmailTemplate.order(name: :asc)
  end

  def show; end

  def edit; end

  def update
    if @template.update(template_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: @resource_name)
      redirect_to admins_email_templates_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  protected

  def template_params
    params.require(:email_template).permit(:name, :content_markdown)
  end

  def set_resource_name
    @resource_name = EmailTemplate.model_name.human
  end

  def set_template
    @template = EmailTemplate.find(params[:id])
  end
end
