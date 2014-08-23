class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @leagues = League.with_user(current_user) if current_user
  end

end
