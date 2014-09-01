class BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :redirect_unless_signed_in

  DEEP_PARAMS = []
  PROCESS_ASSETS = false

  private

  def redirect_unless_signed_in
    redirect_to root_path unless current_user
  end

  def mass_assignable_atts
    _add_deep_params(_allowed_params.slice(*_whitelisted_params))
  end

  def get_users_by_team_id
    Hash[@teams.map {|t| [t.id, @users.detect{|u| u.id == t.owner_id}]}]
  end

  def update_resource
    _resource.attributes = mass_assignable_atts

    if _process_assets?
      _process_assets
    end

    _resource.save
  end


  # ------------------------- plz not call outside of base class

  def _resource
    self.instance_variable_get("@#{_resource_name}")
  end

  def _allowed_params
    @_allowed_params ||= _add_deep_params( params.require(_resource_name).permit(*_whitelisted_params, :asset) )
  end

  def _add_deep_params(atts)
    for att in _deep_params
      atts[att] = params[_resource_name][att]
    end

    atts
  end

  def _resource_name
    self.class::RESOURCE_NAME
  end

  def _whitelisted_params
    self.class::WHITELISTED_PARAMS
  end

  def _deep_params
    self.class::DEEP_PARAMS
  end

  def _asset_params
    _allowed_params.slice(:asset)
  end


  def _process_assets? # TODO implement this junk
    self.class::PROCESS_ASSETS
  end

  def _process_assets
    atts = _asset_params

    if atts[:asset]
      _resource.add_upload(
        Upload.create(asset: atts[:asset], parent_id: _resource.id, parent_type: _resource.class.to_s)
      )
    end

  end

end