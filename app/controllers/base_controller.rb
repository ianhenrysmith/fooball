class BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :redirect_unless_signed_in

  private

  def redirect_unless_signed_in
    redirect_to root unless current_user
  end

  def process_uploads(atts, resource)
    if atts[:asset]
      resource.add_upload(
        Upload.create(asset: atts[:asset], parent_id: resource.id, parent_type: resource.class.to_s)
      )
    end

  end

end