class BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  before_filter :redirect_unless_signed_in

  private

  def redirect_unless_signed_in
    redirect_to root unless current_user
  end

end