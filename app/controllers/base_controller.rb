class BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :redirect_unless_signed_in

  WHITELISTED_PARAMS = []
  RESOURCE_NAME = :smoo

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

  def allowed_params
    @_allowed_params ||= params.require(RESOURCE_NAME).permit(WHITELISTED_PARAMS << :asset)
  end

  def asset_params
    allowed_params.slice(:asset)
  end

  def mass_assignable_atts
    allowed_params.slice(WHITELISTED_PARAMS)
  end

end